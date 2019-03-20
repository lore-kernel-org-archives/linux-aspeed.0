From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Wed, 20 Mar 2019 09:16:07 +0800
Subject: [PATCH v2] usb: introduce usb_ep_type_string() function
In-Reply-To: <20190319092331.GA21652@kroah.com>
References: <28a8e9f1518e47c35e4563706cbe592b972a7f9d.1552977710.git.chunfeng.yun@mediatek.com>
 <1552982059.10179.143.camel@mhfsdcap03> <20190319092331.GA21652@kroah.com>
Message-ID: <1553044567.10179.148.camel@mhfsdcap03>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Greg,

On Tue, 2019-03-19 at 10:23 +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 19, 2019 at 03:54:19PM +0800, Chunfeng Yun wrote:
> > 
> > Hi Felipe & Mathias,
> > 
> > Could you please comment this patch, if there is some-effect on dwc3 and
> > xhci, I'll remove its change.
typo: some-effect/side-effect
> 
> To be specific, you are changing the string values for things that might
> care about it and are seen by userspace.
> 
> Please be explicit about this, as it could cause problems.
Thank you for making it more clearer

> 
> greg k-h


