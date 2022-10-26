From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Date: Wed, 26 Oct 2022 15:02:13 -0400
Subject: [PATCH v10 3/5] media: Documentation: aspeed-video: Add user
 documentation for the aspeed-video driver
In-Reply-To: <22c85f42-a4d7-c6cc-5f1e-346c88c29dc5@aspeedtech.com>
References: <20221025090203.5623-1-jammy_huang@aspeedtech.com>
	 <20221025090203.5623-4-jammy_huang@aspeedtech.com>
	 <8a8f7c818688bda7c75d2f4fb5f8f0d6f89cb965.camel@collabora.com>
	 <22c85f42-a4d7-c6cc-5f1e-346c88c29dc5@aspeedtech.com>
Message-ID: <4e3a4e1961afa77b5658357cc7fa0f289c7409fe.camel@collabora.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Le mercredi 26 octobre 2022 ? 10:42 +0800, Jammy Huang a ?crit?:
> Hi Nicolas,
> 
> Thanks for your comments.
> 
> On 2022/10/25 ?? 09:18, Nicolas Dufresne wrote:
> > Hi Jammy,
> > 
> > thanks for the addition.
> > 
> > Le mardi 25 octobre 2022 ? 17:02 +0800, Jammy Huang a ?crit?:
> > > Add user documentation for the aspeed-video driver.
> > > 
> > > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > > ---
> > > v10:
> > >    - new
> > > ---
> > >   .../media/drivers/aspeed-video.rst            | 61 +++++++++++++++++++
> > >   .../userspace-api/media/drivers/index.rst     |  1 +
> > >   2 files changed, 62 insertions(+)
> > >   create mode 100644 Documentation/userspace-api/media/drivers/aspeed-video.rst
> > > 
> > > diff --git a/Documentation/userspace-api/media/drivers/aspeed-video.rst b/Documentation/userspace-api/media/drivers/aspeed-video.rst
> > > new file mode 100644
> > > index 000000000000..798a2588b175
> > > --- /dev/null
> > > +++ b/Documentation/userspace-api/media/drivers/aspeed-video.rst
> > > @@ -0,0 +1,61 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +.. include:: <isonum.txt>
> > > +
> > > +ASPEED video driver
> > > +===================
> > > +
> > > +ASPEED Video Engine found on AST2400/2500/2600 SoC supports high performance
> > > +video compressions with a wide range of video quality and compression ratio
> > > +options. The adopted compressing algorithm is a modified JPEG algorithm.
> > > +
> > > +There are 2 types of compressions in this IP.
> > > +
> > > +* JPEG JFIF standard mode: for single frame and management compression
> > > +* ASPEED proprietary mode: for multi-frame and differential compression.
> > > +  Support 2-pass (high quality) video compression scheme (Patent pending by
> > > +  ASPEED). Provide visually lossless video compression quality or to reduce
> > > +  the network average loading under intranet KVM applications.
> > I think some of the information disclosed in the following quote could be
> > summarized. Notably the part about the extra buffers.
> > 
> >     Aspeed JPEG Format requires an additional buffer, called bcd, to store
> >     the information about which macro block in the new frame is different
> >     from the previous one.
> >     
> >     To have bcd correctly working, we need to swap the buffers for src0/1 to
> >     make src1 refer to previous frame and src0 to the coming new frame.
> >     
> > But before I push you this route, have you considered using a dedicated pixel
> > format instead ? Here's my thinking, the output of the JPEG encoder is no longer
> > "compatible" (or at least won't yield the expected images) if used with a normal
> > JPEG decoder. By differentiating these two as dedicated formats, you will only need
> > 1 vendor control, and you avoid the potential risk of software bugs mixing them up.
> > Also note that there is other JPEG based vendor formats that exist in V4L2.
> > 
> > Let me know what do you think ?
> 
> Yes, I also add a dedicated formats, V4L2_PIX_FMT_AJPG, in this series. 
> In [PATCH v10 1/5]
> 
> media: v4l: Add definition for the Aspeed JPEG format, I add the 
> description in pixfmt-reserved.rst.
> 
> After this series applied, the users can choose either of these two 
> formats by VIDIOC_S_FMT as
> 
> per their preference.

Sorry about that, I have skipped too much. The approach seems fair then, can you
state in the doc that these control applies to V4L2_PIX_FMT_AJPG in some way ?
(just a little cross-reference can help). The confusion with normal JPEG is
easy.

thanks for you patience,
Nicolas

> 
> > 
> > Nicolas
> > 
> > > +
> > > +More details on the ASPEED video hardware operations can be found in
> > > +*chapter 6.2.16 KVM Video Driver* of SDK_User_Guide which available on
> > > +AspeedTech-BMC/openbmc/releases.
> > > +
> > > +The ASPEED video driver implements the following driver-specific control:
> > > +
> > > +``V4L2_CID_ASPEED_HQ_MODE``
> > > +-------------------------------
> > > +    Enable/Disable ASPEED's High quality mode. This is a private control
> > > +    that can be used to enable high quality for aspeed proprietary mode.
> > > +
> > > +.. flat-table::
> > > +    :header-rows:  0
> > > +    :stub-columns: 0
> > > +    :widths:       1 4
> > > +
> > > +    * - ``(0)``
> > > +      - ASPEED HQ mode is disabled.
> > > +    * - ``(1)``
> > > +      - ASPEED HQ mode is enabled.
> > > +
> > > +``V4L2_CID_ASPEED_HQ_JPEG_QUALITY``
> > > +-------------------------------
> > > +    Define the quality of ASPEED's High quality mode. This is a private control
> > > +    that can be used to decide compression quality if High quality mode enabled
> > > +    . Higher the value, better the quality and bigger the size.
> > > +
> > > +.. flat-table::
> > > +    :header-rows:  0
> > > +    :stub-columns: 0
> > > +    :widths:       1 4
> > > +
> > > +    * - ``(1)``
> > > +      - minimum
> > > +    * - ``(12)``
> > > +      - maximum
> > > +    * - ``(1)``
> > > +      - step
> > > +    * - ``(1)``
> > > +      - default
> > > +
> > > +**Copyright** |copy| 2022 ASPEED Technology Inc.
> > > diff --git a/Documentation/userspace-api/media/drivers/index.rst b/Documentation/userspace-api/media/drivers/index.rst
> > > index 32f82aed47d9..46a494e00b72 100644
> > > --- a/Documentation/userspace-api/media/drivers/index.rst
> > > +++ b/Documentation/userspace-api/media/drivers/index.rst
> > > @@ -31,6 +31,7 @@ For more details see the file COPYING in the source distribution of Linux.
> > >   	:maxdepth: 5
> > >   	:numbered:
> > >   
> > > +	aspeed-video
> > >   	ccs
> > >   	cx2341x-uapi
> > >   	dw100
> 

