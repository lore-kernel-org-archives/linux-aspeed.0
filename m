From: Eddie James <eajames@linux.vnet.ibm.com>
Date: Thu, 17 Oct 2019 15:31:48 -0500
Subject: AST2600 i2c irq issue
In-Reply-To: <CACPK8XdqFkPgCQcgpM5C_YwfJ86Lmk=hG5zTcfbCDCMncXCJMg@mail.gmail.com>
References: <CACPK8XdqFkPgCQcgpM5C_YwfJ86Lmk=hG5zTcfbCDCMncXCJMg@mail.gmail.com>
Message-ID: <f9fecc04-2a9a-4cbd-a1ff-ffb680b0fec2@linux.vnet.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 10/17/19 1:14 AM, Joel Stanley wrote:
> I have been doing bringup of the ast2600. It contains i2c buses that
> are register compatible with the ast2500, and I am running them
> without buffer or DMA mode. This is with v5.3.6, with no patches other
> than adding the compatible string:
>
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -938,6 +938,10 @@ static const struct of_device_id
> aspeed_i2c_bus_of_table[] = {
>                  .compatible = "aspeed,ast2500-i2c-bus",
>                  .data = aspeed_i2c_25xx_get_clk_reg_val,
>          },
> +       {
> +               .compatible = "aspeed,ast2600-i2c-bus",
> +               .data = aspeed_i2c_25xx_get_clk_reg_val,
> +       },
>          { },
>   };
>
>
> I see this behavior:
>
> [   20.981417] aspeed-i2c-bus 1e78a280.i2c-bus: master failed to RX
> [   20.988259] aspeed-i2c-bus 1e78a280.i2c-bus: irq handled != irq.
> expected 0x00000014, but was 0x00000010
> [   22.451265] aspeed-i2c-bus 1e78a200.i2c-bus: master failed to STOP.
> irq_status:0x0
> [   22.459909] aspeed-i2c-bus 1e78a200.i2c-bus: irq handled != irq.
> expected 0x00000010, but was 0x00000000
> [   22.470604] aspeed-i2c-bus 1e78a200.i2c-bus: irq handled != irq.
> expected 0x00000011, but was 0x00000000
> [   29.156951] aspeed-i2c-bus 1e78a280.i2c-bus: master failed to STOP.
> irq_status:0x0
> [   29.165601] aspeed-i2c-bus 1e78a280.i2c-bus: irq handled != irq.
> expected 0x00000010, but was 0x00000000
>
> It happens on boot, and can also be triggered by placing load on the
> system. In particular, if I copy a large amount of data to the flash.
>
> The IRQs are being served on one of the CPUs:
>
>   29:          0          0     GIC-0 142 Level     1e78a080.i2c-bus
>   30:          0          0     GIC-0 143 Level     1e78a100.i2c-bus
>   31:          0          0     GIC-0 144 Level     1e78a180.i2c-bus
>   32:     302596          0     GIC-0 145 Level     1e78a200.i2c-bus
>   33:     197340          0     GIC-0 146 Level     1e78a280.i2c-bus
>   34:     196900          0     GIC-0 147 Level     1e78a300.i2c-bus
>   35:          0          0     GIC-0 149 Level     1e78a400.i2c-bus
>   36:       2199          0     GIC-0 151 Level     1e78a500.i2c-bus
>   37:          0          0     GIC-0 152 Level     1e78a580.i2c-bus
>   38:       3407          0     GIC-0 153 Level     1e78a600.i2c-bus
>   39:          0          0     GIC-0 154 Level     1e78a680.i2c-bus
>   40:          0          0     GIC-0 155 Level     1e78a700.i2c-bus
>
> Following a hunch, I booted the system with SMP disabled (it's a dual
> core part). The issue did not reproduce.
>
> This suggests the driver is lacking locking. I am yet to do any
> detailed debugging.


Been doing some testing.

I'm not sure it's locking, but I think it could have something to do 
with the fact that the driver only acknowledges (clears the irq status 
register) the RX done bit way later than the rest of the bits. Is there 
a reason for this?

It seems to me that we get a second interrupt pending (on the second 
processor? don't see how as we never see any irqs handled there) for RX 
done sometimes, immediately after we've cleared it. I've ONLY seen it on 
RX done. Here's some data to show this:

This is just some custom tracing to track the driver state and the irqs. 
There was too much traffic for dev_dbg to handle. before is the driver 
state before the irq, and after is the driver state after the irq.

0: error entries[10]
 ??? 0: irq[00000000] before[inactive] after[start]
 ??? 1: irq[00000001] before[start] after[tx_first]
 ??? 2: irq[00000001] before[tx_first] after[tx]
 ??? 3: irq[00000001] before[tx] after[start]
 ??? 4: irq[00000005] before[start] after[rx_first]
 ??? 5: irq[00000005] before[rx_first] after[rx]
 ??? 6: irq[00000004] before[rx] after[rx]
 ??? 7: irq[00000004] before[rx] after[stop]??? << all good, transfer is 
complete so we send stop.
 ??? 8: irq[00000000] before[stop] after[inactive]??? << this is the one 
that triggers "failed to STOP" below
 ??? 9: irq[00000010] before[inactive] after[inactive]??? << now we get 
the actual stop, but we're in the wrong state and ignore it
1: error entries[9]
 ??? 0: irq[00000000] before[inactive] after[start]
 ??? 1: irq[00000001] before[start] after[tx_first]
 ??? 2: irq[00000001] before[tx_first] after[tx]
 ??? 3: irq[00000001] before[tx] after[start]
 ??? 4: irq[00000005] before[start] after[rx_first]
 ??? 5: irq[00000005] before[rx_first] after[rx]
 ??? 6: irq[00000004] before[rx] after[rx]???? << all good, transfer is 
continuing
 ??? 7: irq[00000000] before[rx] after[stop]? << no RX during an RX 
operation causes driver to abort and stop
 ??? 8: irq[00000014] before[stop] after[inactive] << now we get the RX 
and the stop.

This corresponds to:

[?? 18.405472] aspeed-i2c-bus 1e78a300.i2c-bus: master failed to STOP. 
irq_status:0x0
[?? 18.414164] aspeed-i2c-bus 1e78a300.i2c-bus: irq handled != irq. 
expected 0x00000010, but was 0x00000000
[?? 21.355422] aspeed-i2c-bus 1e78a300.i2c-bus: master failed to RX
[?? 21.363323] aspeed-i2c-bus 1e78a300.i2c-bus: irq handled != irq. 
expected 0x00000014, but was 0x00000010


I don't understand how disabling SMP fixes this, since the second core 
doesn't seem to ever handle any interrupts. Maybe it's just reporting it 
wrong? From what I understand of interrupt handling, the second core is 
allowed to get interrupts while the first is handling an interrupt and 
has therefore disabled it's own interrupts... correct me if I 
misunderstand. In this case then, RX done gets triggered on the second 
core since it's sitting around uncleared in the status register?


I was also able to "fix" this by simple returning IRQ_NONE if irq_status 
== 0 in the interrupt handler. But probably not a good solution.

Eddie


>
> Have you seen any behavior like this?
