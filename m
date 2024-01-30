From: 'gregkh@linuxfoundation.org' <gregkh@linuxfoundation.org>
Date: Tue, 30 Jan 2024 15:40:56 -0800
Subject: [PATCH 30 1/7] Add JTAG core driver
In-Reply-To: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: <LV8PR11MB846358B901CA67965197C4AB8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Message-ID: <2024013050-humped-tibia-50a9@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 30, 2024 at 11:26:19PM +0000, Corona, Ernesto wrote:
> JTAG class driver provide infrastructure to support hardware/software JTAG platform drivers. It provide user layer API interface for flashing and debugging external devices which equipped with JTAG interface using standard transactions.

Again, properly wrap your changelog please.

And your patch series isn't even threaded, how did you send this?  Just
use 'git send-email' please.

> 
> Driver exposes set of IOCTL to user space for:
> - XFER:
>   SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
>   SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> - GIOCSTATUS read the current TAPC state of the JTAG controller
> - SIOCSTATE Forces the JTAG TAPC to go into a particular state.
> - SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
> - IOCBITBANG for low level control of JTAG signals.
> 
> Driver core provides set of internal APIs for allocation and
> registration:
> - jtag_register;
> - jtag_unregister;
> - jtag_alloc;
> - jtag_free;
> 
> Platform driver on registration with jtag-core creates the next
> entry in dev folder:
> /dev/jtagX

That's a lot for a single patch to do, please break this up into
reviewable chunks.

thanks,

greg k-h
