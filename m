From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 26 Nov 2021 16:08:50 +0800
Subject: [PATCH v5 05/10] media: v4l: Add definition for the Aspeed JPEG
 format
In-Reply-To: <YZzBPFHZ7MPwTWSm@paasikivi.fi.intel.com>
References: <20211118074030.685-1-jammy_huang@aspeedtech.com>
 <20211118074030.685-6-jammy_huang@aspeedtech.com>
 <YZZIDNCLJXwrqY4W@paasikivi.fi.intel.com>
 <0bed6093-0af6-4fc4-716f-6cf8b1302320@aspeedtech.com>
 <YZzBPFHZ7MPwTWSm@paasikivi.fi.intel.com>
Message-ID: <b66655ac-eac8-835a-7917-0c1d035d5309@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 2021/11/23 ?? 06:23, Sakari Ailus wrote:
> Hi Jammy,
>
> On Fri, Nov 19, 2021 at 10:02:40AM +0800, Jammy Huang wrote:
>> Hi Sakari,
>>
>> On 2021/11/18 ?? 08:33, Sakari Ailus wrote:
>>> Hi Jammy,
>>>
>>> On Thu, Nov 18, 2021 at 03:40:26PM +0800, Jammy Huang wrote:
>>>> This introduces support for the Aspeed JPEG format, where the new frame
>>>> can refer to previous frame to reduce the amount of compressed data. The
>>>> concept is similar to I/P frame of video compression. I will compare the
>>>> new frame with previous one to decide which macroblock's data is
>>>> changed, and only the changed macroblocks will be compressed.
>>>>
>>>> This Aspeed JPEG format is used by the video engine on Aspeed platforms,
>>>> which is generally adapted for remote KVM.
>>>>
>>>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>>>> ---
>>>> v5:
>>>>     - no update
>>>> v4:
>>>>     - new
>>>> ---
>>>>    Documentation/media/uapi/v4l/pixfmt-reserved.rst | 12 ++++++++++++
>>>>    drivers/media/v4l2-core/v4l2-ioctl.c             |  1 +
>>>>    include/uapi/linux/videodev2.h                   |  1 +
>>>>    3 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/media/uapi/v4l/pixfmt-reserved.rst b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
>>>> index b2cd155e691b..23c05063133d 100644
>>>> --- a/Documentation/media/uapi/v4l/pixfmt-reserved.rst
>>>> +++ b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
>>>> @@ -264,6 +264,18 @@ please make a proposal on the linux-media mailing list.
>>>>    	of tiles, resulting in 32-aligned resolutions for the luminance plane
>>>>    	and 16-aligned resolutions for the chrominance plane (with 2x2
>>>>    	subsampling).
>>>> +    * .. _V4L2-PIX-FMT-AJPG:
>>>> +
>>>> +      - ``V4L2_PIX_FMT_AJPG``
>>>> +      - 'AJPG'
>>>> +      - ASPEED JPEG format used by the aspeed-video driver on Aspeed platforms,
>>>> +        which is generally adapted for remote KVM.
>>>> +        On each frame compression, I will compare the new frame with previous
>>>> +        one to decide which macroblock's data is changed, and only the changed
>>>> +        macroblocks will be compressed.
>>>> +
>>>> +        You could reference to chapter 36, Video Engine, of AST2600's datasheet
>>>> +        for more information.
>>> Is this datasheet publicly available? Do you have a URL?
>> Sorry, this datasheet is not publicly available.
>> Hans mentioned this as well in the discussion below:
>>
>> https://lkml.org/lkml/2021/11/10/101
> If the vendor documentation is not publicly available, you'll need to have
> the format documented here. Alternatively an open source implementation
> (e.g. LGPL) is presumably fine, too.
Please refer to 
https://github.com/AspeedTech-BMC/openbmc/releases/download/v07.02/SDK_User_Guide_v07.02.pdf.
At Page 132, 'Video stream data format ? ASPEED mode compression' 
describes the data format.
Is above information? enough??

Besides, I have already had openbmc's kvm support this aspeed format.
The source code of the implementation will be released after performance 
tuning finished.

-- 
Best Regards
Jammy

