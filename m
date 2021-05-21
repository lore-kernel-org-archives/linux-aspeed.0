From: Joel Stanley <joel@jms.id.au>
Date: Fri, 21 May 2021 02:43:05 +0000
Subject: [PATCH v2] i2c: aspeed: disable additional device addresses on
 ast2[56]xx
In-Reply-To: <CAFd5g46TEFLWdBN80RxGwZfoyD-70C0pP59mhrynvD5ODd2wrg@mail.gmail.com>
References: <20210506205419.26294-1-zev@bewilderbeest.net>
 <CAFd5g46TEFLWdBN80RxGwZfoyD-70C0pP59mhrynvD5ODd2wrg@mail.gmail.com>
Message-ID: <CACPK8XfYJjuBHSA=8gojb7YiPc9AeH5sMd08amx_=GgjEKe_eg@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 7 May 2021 at 19:57, Brendan Higgins <brendanhiggins@google.com> wrote:
>
> On Thu, May 6, 2021 at 1:54 PM Zev Weiss <zev@bewilderbeest.net> wrote:
> >
> > The ast25xx and ast26xx have, respectively, two and three configurable
> > slave device addresses to the ast24xx's one.  We only support using
> > one at a time, but the others may come up in an indeterminate state
> > depending on hardware/bootloader behavior, so we need to make sure we
> > disable them so as to avoid ending up with phantom devices on the bus.
> >
> > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
> Looks great! No concerns from me.
>
> Nevertheless, I am not in a position to test this at this time. Joel,
> or Andrew could one of you (or someone else on the mailing list) test
> this?

I tried testing this by connecting I2C1 and I2C2 (schematic numbering)
on the AST2600A2 EVB. I got it working, but only when I read a single
byte. There's more about that below, but it's a different issue
unrelated to this patch.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>

--
On to the bug I saw:

When reading one byte, it works:

root at ast2600a2:~# dd status=none
if=/sys/bus/i2c/devices/i2c-2/2-0064/eeprom  count=1 bs=1| hexdump -C
00000000  48                                                |H|

If I try to read more than one byte:

root at ast2600a2:~# dd status=none
if=/sys/bus/i2c/devices/i2c-2/2-0064/eeprom  count=1 bs=2 | hexdump -C
[ 1568.320096] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1568.328385] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1568.339106] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1568.347423] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1568.358112] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1568.366430] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
dd: error reading '/sys/bus/i2c/devices/i2c-2/2-0064/eeprom':
Connection timed out


If I then go back to reading one byte, I get the error the first time
but the data does come out:

root at ast2600a2:~# dd status=none
if=/sys/bus/i2c/devices/i2c-2/2-0064/eeprom  count=1 bs=1 | hexdump -C
[ 1593.306360] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1593.315191] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
00000000  48                                                |H|
00000001

Subsequent reads work as expected.

With further debugging turned on, this is the log of doing a two byte read:

[ 1781.027360] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1781.027552] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000004, cmd 0xec0b0000
[ 1781.027751] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1781.027906] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000001, cmd 0xea250000
[ 1781.028069] aspeed-i2c-bus 1e78a180.i2c-bus: received error
interrupt: 0x00000008
[ 1781.029683] aspeed-i2c-bus 1e78a180.i2c-bus: SDA hung (state
a050000), attempting recovery
[ 1781.029760] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000004, cmd 0xd2b10004
[ 1781.029773] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1781.038729] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000020, cmd 0x0a050000
[ 1781.038761] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1781.046932] aspeed-i2c-bus 1e78a100.i2c-bus: received error
interrupt: 0x00000020
[ 1781.047022] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1781.047195] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000004, cmd 0xec0b0000
[ 1781.047404] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1781.047556] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000001, cmd 0xea250000
[ 1781.047756] aspeed-i2c-bus 1e78a180.i2c-bus: received error
interrupt: 0x00000008
[ 1781.049367] aspeed-i2c-bus 1e78a180.i2c-bus: SDA hung (state
a050000), attempting recovery
[ 1781.049421] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000004, cmd 0xd2b10004
[ 1781.049435] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1781.058322] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000020, cmd 0x0a050000
[ 1781.058351] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1781.066522] aspeed-i2c-bus 1e78a100.i2c-bus: received error
interrupt: 0x00000020
[ 1781.066609] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1781.066789] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000004, cmd 0xec0b0000
[ 1781.066998] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1781.067148] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000001, cmd 0xea250000
[ 1781.067313] aspeed-i2c-bus 1e78a180.i2c-bus: received error
interrupt: 0x00000008
[ 1781.068968] aspeed-i2c-bus 1e78a180.i2c-bus: SDA hung (state
a050000), attempting recovery
[ 1781.069083] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000004, cmd 0xd2b10004
[ 1781.069100] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1781.077903] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000020, cmd 0x0a050000
[ 1781.077934] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1781.086106] aspeed-i2c-bus 1e78a100.i2c-bus: received error
interrupt: 0x00000020
[ 1781.086186] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1781.086371] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000004, cmd 0xec0b0000
[ 1781.086579] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1781.086730] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000001, cmd 0xea250000
[ 1781.086897] aspeed-i2c-bus 1e78a180.i2c-bus: received error
interrupt: 0x00000008

This is the result of the first single byte read after the error state:

[ 1710.150555] aspeed-i2c-bus 1e78a180.i2c-bus: SDA hung (state
a050000), attempting recovery
[ 1710.150627] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000004, cmd 0xd2350004
[ 1710.150646] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1710.159468] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000020, cmd 0x0a050000
[ 1710.159500] aspeed-i2c-bus 1e78a100.i2c-bus: Expected ACK after
processed read.
[ 1710.167681] aspeed-i2c-bus 1e78a100.i2c-bus: received error
interrupt: 0x00000020
[ 1710.167793] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1710.167971] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000004, cmd 0xec0b0000
[ 1710.168178] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000084, cmd 0xec0b0000
[ 1710.168335] aspeed-i2c-bus 1e78a100.i2c-bus: slave irq status
0x00000002, cmd 0x0a070000

This is unrelated to your change, but should be investigated by anyone
looking at slave support on the ast2600.

Lets go ahead with merging this change.


>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
