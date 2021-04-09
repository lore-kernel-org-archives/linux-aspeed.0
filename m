From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Apr 2021 12:51:34 +0300
Subject: [PATCH v5 2/4] drivers/tty/serial/8250: refactor sirq and lpc
 address setting code
In-Reply-To: <YHAEfn4li6F8L9JC@hatter.bewilderbeest.net>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-3-zev@bewilderbeest.net>
 <CAHp75Vd6kk0E-kALEGOhsg=YHKhmKLY6cpCTdviOFenO4p1-2A@mail.gmail.com>
 <YHAEfn4li6F8L9JC@hatter.bewilderbeest.net>
Message-ID: <CAHp75VfpE-AvhzN216KwJvxQ25euGTN_kziJ0hKxYCOXXA2BTw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 9, 2021 at 10:38 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Fri, Apr 09, 2021 at 02:24:08AM CDT, Andy Shevchenko wrote:
> >On Thursday, April 8, 2021, Zev Weiss <zev@bewilderbeest.net> wrote:
> >
> >> This splits dedicated aspeed_vuart_set_{sirq,lpc_address}() functions
> >> out of the sysfs store functions in preparation for adding DT
> >> properties that will be poking the same registers.  While we're at it,
> >> these functions now provide some basic bounds-checking on their
> >> arguments.
> >>
> >>
> >
> >Please, use prefix ?serial: 8250_aspeed_vuart:? instead of what you have in
> >the subject line. I think I have told this already
> >
> >
>
> Ah, sorry -- I fixed the cover letter after your first comment (which
> had definitely been under-tagged); for the patches themselves I was
> following the example of the last patch in that particular area
> (8d310c9107a2), though I guess that wasn't the right model to follow.
> I'll use the requested format in the future.

Just random amount of most recent patches against 8250 driver:

e47eb5241a8f serial: 8250: Avoid new transfers when shutting down
e49950d3e737 serial: 8250_dma: use linear buffer for transmit
34255381fabd serial: 8250_port: Try to run DMA Rx on timeout condition
7d7dec450a66 8250_tegra: clean up tegra_uart_handle_break
c3ae3dc896fa serial: 8250_pci: Drop bogus __refdata annotation
d96f04d347e4 serial: 8250_omap: Avoid FIFO corruption caused by MDR1 access
6e4e636e0e3e serial: 8250-mtk: Fix reference leak in mtk8250_probe
a609c58086e3 tty: serial: 8250: 8250_port: Move prototypes to shared location
6f9918504129 serial: 8250: 8250_omap: Fix unused variable warning
d4548b14dd7e serial: 8250: 8250_omap: Fix possible array out of bounds access
912ab37c7987 serial: 8250_mtk: Fix uart_get_baud_rate warning
439c7183e5b9 serial: 8250: 8250_omap: Disable RX interrupt after DMA enable
32ed248042d1 tty: serial: 8250: serial_cs: Remove unused/unchecked
variable 'err'
85985a3dcd74 serial: 8250_dw: Fix clk-notifier/port suspend deadlock
c8dff3aa8241 serial: 8250: Skip uninitialized TTY port baud rate update
7718453e3696 serial: 8250: Discard RTS/DTS setting from clock update method
409cc4541ade serial: 8250_fsl: Fix TX interrupt handling condition
3c5a87be170a serial: 8250_pci: Add Realtek 816a and 816b
ea4de367e57d tty: serial: 8250_mtk: set regshift for mmio32
57cee0713118 serial: 8250_pci: Remove unused function get_pci_irq()
11361610b005 serial: 8250_fsl: Add ACPI support




-- 
With Best Regards,
Andy Shevchenko
