From: Hongwei Zhang <hongweiz@ami.com>
Date: Tue, 22 Dec 2020 15:14:37 -0500
Subject: [Aspeed,
 v2 2/2] net: ftgmac100: Change the order of getting MAC address
In-Reply-To: <20201221205157.31501-2-hongweiz@ami.com>
References: <20201221205157.31501-2-hongweiz@ami.com>
Message-ID: <20201222201437.5588-3-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Reviewer,

Use native MAC address is preferred over other choices, thus change the order
of reading MAC address, try to read it from MAC chip first, if it's not
 availabe, then try to read it from device tree.


Hi Heiner,

> From:	Heiner Kallweit <hkallweit1@gmail.com>
> Sent:	Monday, December 21, 2020 4:37 PM
> > Change the order of reading MAC address, try to read it from MAC chip 
> > first, if it's not availabe, then try to read it from device tree.
> > 
> This commit message leaves a number of questions. It seems the change isn't related at all to the 
> change that it's supposed to fix.
> 
> - What is the issue that you're trying to fix?
> - And what is wrong with the original change?

There is no bug or something wrong with the original code. This patch is for
improving the code. We thought if the native MAC address is available, then
it's preferred over MAC address from dts (assuming both sources are available).

One possible scenario, a MAC address is set in dts and the BMC image is 
compiled and loaded into more than one platform, then the platforms will
have network issue due to the same MAC address they read.

Thanks for your review, I've update the patch to fix the comments.
> 
> > Fixes: 35c54922dc97 ("ARM: dts: tacoma: Add reserved memory for 
> > ramoops")
> > Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
> > ---
> >  drivers/net/ethernet/faraday/ftgmac100.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)

--Hongwei
