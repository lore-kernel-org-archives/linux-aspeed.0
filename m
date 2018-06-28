From: Joel Stanley <joel@jms.id.au>
Date: Thu, 28 Jun 2018 14:33:35 +0930
Subject: [PATCH 12/14] fsi: master-ast-cf: Add new FSI master using Aspeed
 ColdFire
In-Reply-To: <20180626232605.13420-13-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-13-benh@kernel.crashing.org>
Message-ID: <CACPK8XfkxFZixL+5e5Spzo-=uJDXgojNMncn6k+upxJH+D=+eQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ben,

On 27 June 2018 at 08:56, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> The Aspeed AST2x00 can contain a ColdFire v1 coprocessor which
> is currently unused on OpenPower systems.
>
> This adds an alternative to the fsi-master-gpio driver that
> uses that coprocessor instead of bit banging from the ARM
> core itself. The end result is about 4 times faster.
>
> The firmware for the coprocessor and its source code can be
> found at https://github.com/ozbenh/cf-fsi and is system specific.
>
> Currently tested on Romulus and Palmetto systems.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Nice work. I gave this a spin on Romulus and it looked good.

If you run it through sparse there are a bunch of things to fix. I've
also got some comments below.

> --- /dev/null
> +++ b/drivers/fsi/cf-fsi-fw.h
> @@ -0,0 +1,131 @@


Copyright?

> +#ifndef __CF_FSI_FW_H
> +#define __CF_FSI_FW_H
> +
> +/*
> + * uCode file layout
> + *
> + * 0000...03ff : m68k exception vectors
> + * 0400...04ff : Header info & boot config block
> + * 0500....... : Code & stack
> + */

> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> new file mode 100644
> index 000000000000..6b17f27c27f6
> --- /dev/null
> +++ b/drivers/fsi/fsi-master-ast-cf.c
> @@ -0,0 +1,1376 @@
> +// SPDX-License-Identifier: GPL-2.0

Normally 2+ for new IBM code? You also need something like this on the
next line:

// Copyright 2018 IBM Corp

> +static int read_copro_response(struct fsi_master_acf *master, uint8_t size,
> +                              __be32 *response, u8 *tag)
> +{
> +       u8 rtag = readb(master->sram + STAT_RTAG);
> +       u8 rcrc = readb(master->sram + STAT_RCRC);
> +       __be32 rdata = 0;
> +       u32 crc;
> +       u8 ack;
> +
> +       *tag = ack = rtag & 3;
> +
> +       /* we have a whole message now; check CRC */
> +       crc = crc4(0, 1, 1);
> +       crc = crc4(crc, rtag, 4);
> +       if (ack == FSI_RESP_ACK && size) {
> +               rdata = readl(master->sram + RSP_DATA);
> +               crc = crc4(crc, be32_to_cpu(rdata), 32);
> +               if (response)
> +                       *response = rdata;
> +       }
> +       crc = crc4(crc, rcrc, 4);
> +
> +       trace_fsi_master_acf_copro_response(master, rtag, rcrc, rdata, crc == 0);
> +
> +       if (crc) {
> +               /*
> +                * Check if it's all 1's or all 0's, that probably means
> +                * the host is off
> +                */
> +               if ((rtag == 0xf && rcrc == 0xf) || (rtag == 0 && rcrc == 0))
> +                       return -ENODEV;
> +               dev_dbg(master->dev, "Bad response CRC !\n");
> +               return -EAGAIN;
> +       }
> +       return 0;
> +}
> +
> +static int send_term(struct fsi_master_acf *master, uint8_t slave)
> +{
> +       struct fsi_msg cmd;
> +       uint8_t tag;
> +       int rc;
> +
> +       build_term_command(&cmd, slave);
> +
> +       rc = send_request(master, &cmd, true);
> +       if (rc) {
> +               dev_warn(master->dev, "Error %d sending term\n", rc);
> +               return rc;
> +       }
> +
> +       rc = read_copro_response(master, 0, NULL, &tag);
> +       if (rc < 0) {
> +               dev_err(master->dev,
> +                               "TERM failed; lost communication with slave\n");
> +               return -EIO;
> +       } else if (tag != FSI_RESP_ACK) {
> +               dev_err(master->dev, "TERM failed; response %d\n", tag);
> +               return -EIO;
> +       }
> +       return 0;
> +}
> +
> +static void dump_trace(struct fsi_master_acf *master)
> +{
> +       char trbuf[52];

I was checking that this was big enough.

52 = 16 * 3 + '\n' + \0' = 50?

Looks to be okay.

> +       char *p;
> +       int i;
> +
> +       dev_dbg(master->dev,
> +               "CMDSTAT:%08x RTAG=%02x RCRC=%02x RDATA=%02x #INT=%08x\n",
> +              be32_to_cpu(readl(master->sram + CMD_STAT_REG)),
> +              readb(master->sram + STAT_RTAG),
> +              readb(master->sram + STAT_RCRC),
> +              be32_to_cpu(readl(master->sram + RSP_DATA)),
> +              be32_to_cpu(readl(master->sram + INT_CNT)));
> +
> +       for (i = 0; i < 512; i++) {
> +               uint8_t v;
> +               if ((i % 16) == 0)
> +                       p = trbuf;
> +               v = readb(master->sram + TRACEBUF + i);
> +               p += sprintf(p, "%02x ", v);
> +               if (((i % 16) == 15) || v == TR_END)
> +                       dev_dbg(master->dev, "%s\n", trbuf);
> +               if (v == TR_END)
> +                       break;
> +       }
> +}
> +
> +static int handle_response(struct fsi_master_acf *master,
> +                          uint8_t slave, uint8_t size, void *data)
> +{
> +       int busy_count = 0, rc;
> +       int crc_err_retries = 0;
> +       struct fsi_msg cmd;
> +       __be32 response;
> +       uint8_t tag;
> +retry:
> +       rc = read_copro_response(master, size, &response, &tag);
> +
> +       /* Handle retries on CRC errors */
> +       if (rc == -EAGAIN) {
> +               /* Too many retries ? */
> +               if (crc_err_retries++ > FSI_CRC_ERR_RETRIES) {
> +                       /*
> +                        * Pass it up as a -EIO otherwise upper level will retry
> +                        * the whole command which isn't what we want here.
> +                        */
> +                       rc = -EIO;
> +                       goto bail;
> +               }
> +               trace_fsi_master_acf_crc_rsp_error(master, crc_err_retries);
> +               if (master->trace_enabled)
> +                       dump_trace(master);
> +               rc = clock_zeros(master, FSI_MASTER_EPOLL_CLOCKS);
> +               if (rc) {
> +                       dev_warn(master->dev,
> +                                "Error %d clocking zeros for E_POLL\n", rc);
> +                       return rc;
> +               }
> +               build_epoll_command(&cmd, slave);
> +               rc = send_request(master, &cmd, size == 0);
> +               if (rc) {
> +                       dev_warn(master->dev, "Error %d sending E_POLL\n", rc);
> +                       return -EIO;
> +               }
> +               goto retry;
> +       }
> +       if (rc)
> +               return rc;
> +
> +       switch (tag) {
> +       case FSI_RESP_ACK:
> +               if (size && data) {
> +                       if (size == 4)
> +                               *(__be32 *)data = response;
> +                       else if (size == 2)
> +                               *(__be16 *)data = response;
> +                       else
> +                               *(u8 *)data = response;

Response is a u32, the idea here is to discard the top two or three byes?

> +
> +static int fsi_master_acf_setup(struct fsi_master_acf *master)
> +{
> +       int timeout, rc;
> +       u32 val;
> +

> +
> +       /* Wait for status register to indicate command completion
> +        * which signals the initialization is complete
> +        */
> +       for (timeout = 0; timeout < 10; timeout++) {
> +               val = readb(master->sram + CF_STARTED);
> +               if (val)
> +                       break;
> +               msleep(1);
> +       };

drivers/fsi/fsi-master-ast-cf.c:920:2-3: Unneeded semicolon

> +       if (!val) {
> +               dev_err(master->dev, "Coprocessor startup timeout !\n");
> +               rc = -ENODEV;
> +               goto err;
> +       }
> +
> +       /* Configure echo & send delay */
> +       writeb(master->t_send_delay, master->sram + SEND_DLY_REG);
> +       writeb(master->t_echo_delay, master->sram + ECHO_DLY_REG);
> +
> +       /* Enable SW interrupt to copro if any */
> +       if (master->cvic) {
> +               rc = copro_enable_sw_irq(master);
> +               if (rc)
> +                       goto err;
> +       }
> +       return 0;
> + err:
> +       /* An error occurred, don't leave the coprocessor running */
> +       reset_cf(master);
> +
> +       /* Release the GPIOs */
> +       release_copro_gpios(master);
> +
> +       return rc;
> +}

> +static int fsi_master_acf_gpio_request(void *data)
> +{
> +       struct fsi_master_acf *master = data;
> +       int timeout;
> +       u8 val;
> +
> +       /* Note: This doesn't require holding out mutex */
> +
> +       /* Write reqest */
> +       writeb(ARB_ARM_REQ, master->sram + ARB_REG);
> +
> +       /* Read back to avoid ordering issue */
> +       (void)readb(master->sram + ARB_REG);
> +
> +       /*
> +        * There is a race (which does happen at boot time) when we get an
> +        * arbitration request as we are either about to or just starting
> +        * the coprocessor.
> +        *
> +        * To handle it, we first check if we are running. If not yet we
> +        * check whether the copro is started in the SCU.
> +        *
> +        * If it's not started, we can basically just assume we have arbitration
> +        * and return. Otherwise, we wait normally expecting for the arbitration
> +        * to eventually complete.
> +        */
> +       if (readl(master->sram + CF_STARTED) == 0) {
> +               unsigned int reg = 0;
> +
> +               regmap_read(master->scu, SCU_COPRO_CTRL, &reg);
> +               if (!reg & SCU_COPRO_CLK_EN)

Is this correct? Looks like it might be missing some ( )

> +                       return 0;
> +       }
> +
> +       /* Ring doorbell if any */
> +       if (master->cvic)
> +               writel(0x2, master->cvic + CVIC_TRIG_REG);
> +
> +       for (timeout = 0; timeout < 10000; timeout++) {
> +               val = readb(master->sram + ARB_REG);
> +               if (val != ARB_ARM_REQ)
> +                       break;
> +               udelay(1);
> +       }
> +
> +       /* If it failed, override anyway */
> +       if (val != ARB_ARM_ACK)
> +               dev_warn(master->dev, "GPIO request arbitration timeout\n");
> +
> +       return 0;
> +}
> +
