From: Hongwei Zhang <hongweiz@ami.com>
Date: Mon, 4 Jan 2021 12:28:07 -0500
Subject: [Aspeed,
 v1 1/1] net: ftgmac100: Change the order of getting MAC address 
In-Reply-To: <20201221205157.31501-2-hongweiz@ami.com>
References: <20201221205157.31501-2-hongweiz@ami.com>
Message-ID: <20210104172807.20986-1-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, December 28, 2020 5:01 PM
>
> On Tue, 22 Dec 2020 22:00:34 +0100 Andrew Lunn wrote:
> > On Tue, Dec 22, 2020 at 09:46:52PM +0100, Heiner Kallweit wrote:
> > > On 22.12.2020 21:14, Hongwei Zhang wrote:
> > > > Dear Reviewer,
> > > >
> > > > Use native MAC address is preferred over other choices, thus change the order
> > > > of reading MAC address, try to read it from MAC chip first, if it's not
> > > >  availabe, then try to read it from device tree.
> > > >
> > > > Hi Heiner,
> > > >
> > > >> From:  Heiner Kallweit <hkallweit1@gmail.com>
> > > >> Sent:  Monday, December 21, 2020 4:37 PM
> > > >>> Change the order of reading MAC address, try to read it from MAC chip
> > > >>> first, if it's not availabe, then try to read it from device tree.
> > > >>>
> > > >> This commit message leaves a number of questions. It seems the change isn't related at all to the
> > > >> change that it's supposed to fix.
> > > >>
> > > >> - What is the issue that you're trying to fix?
> > > >> - And what is wrong with the original change?
> > > >
> > > > There is no bug or something wrong with the original code. This patch is for
> > > > improving the code. We thought if the native MAC address is available, then
> > > > it's preferred over MAC address from dts (assuming both sources are available).
> > > >
> > > > One possible scenario, a MAC address is set in dts and the BMC image is
> > > > compiled and loaded into more than one platform, then the platforms will
> > > > have network issue due to the same MAC address they read.
> > > >
> > >
> > > Typically the DTS MAC address is overwritten by the boot loader, e.g. uboot.
> > > And the boot loader can read it from chip registers. There are more drivers
> > > trying to read the MAC address from DTS first. Eventually, I think, the code
> > > here will read the same MAC address from chip registers as uboot did before.

Thanks for your review, Heiner,

I am working on a platform and want to use the method you said, reading from DTS
is easy, but overwrite the MAC in DTS with chip MAC address, it will change the
checksum of the image. Would you please provide an implementation example?

Thanks!
> >
> > Do we need to worry about, the chip contains random junk, which passes
> > the validitiy test? Before this patch the value from DT would be used,
> > and the random junk is ignored. Is this change possibly going to cause
> > a regression?

Hi Andrew,

Thanks for your review. Yes, yours is a good point, as my change relies on
the driver's ability to read correct MAC from the chip, or the check of
is_valid_ether_addr(), which only checking for zeros and multicasting MAC.
On the other hand, your concern is still true if no MAC is defined in DTS
file.

Thanks!
>
> Hongwei, please address Andrew's questions.
>
> Once the discussion is over please repost the patches as
> git-format-patch would generate them. The patch 2/2 of this
> series is not really a patch, which confuses all patch handling
> systems.
>
> It also appears that 35c54922dc97 ("ARM: dts: tacoma: Add reserved
> memory for ramoops") does not exist upstream.
>

Hi Jakub,

Thanks for your review; I am quite new to the contribution process. I will resubmit my
patch with the SHA value issue fixed. Please see my response at above.

--Hongwei

-- 
2.17.1

