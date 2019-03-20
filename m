From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Wed, 20 Mar 2019 15:49:42 +0800
Subject: [PATCH v2] usb: introduce usb_ep_type_string() function
In-Reply-To: <87r2b2ujao.fsf@linux.intel.com>
References: <28a8e9f1518e47c35e4563706cbe592b972a7f9d.1552977710.git.chunfeng.yun@mediatek.com>
 <1552982059.10179.143.camel@mhfsdcap03> <20190319092331.GA21652@kroah.com>
 <1553044567.10179.148.camel@mhfsdcap03> <87r2b2ujao.fsf@linux.intel.com>
Message-ID: <1553068182.10179.166.camel@mhfsdcap03>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Felipe,

On Wed, 2019-03-20 at 08:55 +0200, Felipe Balbi wrote:
> Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> 
> > Hi Greg,
> >
> > On Tue, 2019-03-19 at 10:23 +0100, Greg Kroah-Hartman wrote:
> >> On Tue, Mar 19, 2019 at 03:54:19PM +0800, Chunfeng Yun wrote:
> >> > 
> >> > Hi Felipe & Mathias,
> >> > 
> >> > Could you please comment this patch, if there is some-effect on dwc3 and
> >> > xhci, I'll remove its change.
> > typo: some-effect/side-effect
> 
> well, we don't really know if there are tools parsing the output. The
> side-effect _does_ exist (i.e. you change the string :-), what we don't
> know is if this will cause problems to possibly existing tools.
> 
> Personally, I don't mind the patch, but if it breaks existing parsers,
> that would be a little annoying.
Thank you for the feedback.

I'll abandon the changes about dwc3 & xhci
> 


