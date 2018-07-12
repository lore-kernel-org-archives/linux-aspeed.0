From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 12 Jul 2018 12:01:29 +1000
Subject: [PATCH 06/14] fsi: master-gpio: Add more tracepoints
In-Reply-To: <CACPK8XfZPCiCPeNL5-TpPMcHrA_fyiLu=5pArSxBXd6wT8jkFA@mail.gmail.com>
References: <20180626232605.13420-1-benh@kernel.crashing.org>
 <20180626232605.13420-7-benh@kernel.crashing.org>
 <CACPK8XfZPCiCPeNL5-TpPMcHrA_fyiLu=5pArSxBXd6wT8jkFA@mail.gmail.com>
Message-ID: <e25f7a0b1d529b57a2994681101a3633849cdc1b.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2018-06-28 at 13:41 +0930, Joel Stanley wrote:
> On 27 June 2018 at 08:55, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > This adds a few more tracepoints that have proven useful when
> > debugging issues with the FSI bus.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> > ---
> >  drivers/fsi/fsi-master-gpio.c          | 16 ++++---
> >  include/trace/events/fsi_master_gpio.h | 59 ++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
> > index 48e0e65b2982..a00a85aa6d56 100644
> > --- a/drivers/fsi/fsi-master-gpio.c
> > +++ b/drivers/fsi/fsi-master-gpio.c
> > @@ -130,10 +130,17 @@ static void set_sda_output(struct fsi_master_gpio *master, int value)
> > 
> >  static void clock_zeros(struct fsi_master_gpio *master, int count)
> >  {
> > +       trace_fsi_master_gpio_clock_zeros(master, count);
> >         set_sda_output(master, 1);
> >         clock_toggle(master, count);
> >  }
> > 
> > +static void echo_delay(struct fsi_master_gpio *master)
> > +{
> > +       clock_zeros(master, master->t_echo_delay);
> > +}
> 
> This doesn't look like it belongs in this patch.
> 
> You've just moved it up. Not worth a re-spin.

I've done more, I made it use clock_zeros() instead of open coding it
in order to share the tracepoint.
> 
> > +
> > +
> >  static void serial_in(struct fsi_master_gpio *master, struct fsi_gpio_msg *msg,
> >                         uint8_t num_bits)
> >  {
> > @@ -279,16 +286,19 @@ static void build_ar_command(struct fsi_master_gpio *master,
> >                 addr_bits = 2;
> >                 opcode_bits = 2;
> >                 opcode = FSI_GPIO_CMD_SAME_AR;
> > +               trace_fsi_master_gpio_cmd_same_addr(master);
> > 
> >         } else if (check_relative_address(master, id, addr, &rel_addr)) {
> >                 /* 8 bits plus sign */
> >                 addr_bits = 9;
> >                 addr = rel_addr;
> >                 opcode = FSI_GPIO_CMD_REL_AR;
> > +               trace_fsi_master_gpio_cmd_rel_addr(master, rel_addr);
> > 
> >         } else {
> >                 addr_bits = 21;
> >                 opcode = FSI_GPIO_CMD_ABS_AR;
> > +               trace_fsi_master_gpio_cmd_abs_addr(master, addr);
> >         }
> > 
> >         /*
> > @@ -337,12 +347,6 @@ static void build_epoll_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
> >         msg_push_crc(cmd);
> >  }
> > 
> > -static void echo_delay(struct fsi_master_gpio *master)
> > -{
> > -       set_sda_output(master, 1);
> > -       clock_toggle(master, master->t_echo_delay);
> > -}
> > -
> >  static void build_term_command(struct fsi_gpio_msg *cmd, uint8_t slave_id)
> >  {
> >         cmd->bits = 0;
