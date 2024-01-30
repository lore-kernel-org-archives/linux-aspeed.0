From: 'gregkh@linuxfoundation.org' <gregkh@linuxfoundation.org>
Date: Tue, 30 Jan 2024 15:39:13 -0800
Subject: [PATCH 30 5/7] Add JTAG core driver ioctl number
In-Reply-To: <LV8PR11MB84634960758E20E781DB638F8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
References: <LV8PR11MB84634960758E20E781DB638F8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Message-ID: <2024013024-starship-referee-7ab3@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 30, 2024 at 11:32:14PM +0000, Corona, Ernesto wrote:
> JTAG class driver provide infrastructure to support hardware/software JTAG platform drivers. It provide user layer API interface for flashing and debugging external devices which equipped with JTAG interface using standard transactions.

Please properly wrap your changelog text, didn't checkpatch warn of
this?

> Driver exposes set of IOCTL to user space for:
> - XFER:
>   SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
>   SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> - GIOCSTATUS read the current TAPC state of the JTAG controller
> - SIOCSTATE Forces the JTAG TAPC to go into a particular state.
> - SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
> - IOCBITBANG for low level control of JTAG signals.

Where are these ioctls implemented?  THat has nothing to do with this
patch itself, right?

And what's the "30" in the patch number above for?

confused,

greg k-h
