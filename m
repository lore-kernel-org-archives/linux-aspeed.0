From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Fri, 19 Nov 2021 17:37:47 +0800
Subject: [PATCH v5 05/10] media: v4l: Add definition for the Aspeed JPEG
 format
In-Reply-To: <1cc9afa7-397e-64a0-9f1b-b4d3bd85a8f0@molgen.mpg.de>
References: <20211118074030.685-1-jammy_huang@aspeedtech.com>
 <20211118074030.685-6-jammy_huang@aspeedtech.com>
 <YZZIDNCLJXwrqY4W@paasikivi.fi.intel.com>
 <0bed6093-0af6-4fc4-716f-6cf8b1302320@aspeedtech.com>
 <1cc9afa7-397e-64a0-9f1b-b4d3bd85a8f0@molgen.mpg.de>
Message-ID: <b38e52d3-2800-ea59-1008-d5327c1c3e40@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Paul,

OK, thanks for your suggestion.

On 2021/11/19 ?? 04:39, Paul Menzel wrote:
> Dear Jammy,
>
>
> Am 19.11.21 um 03:02 schrieb Jammy Huang:
>
>> On 2021/11/18 ?? 08:33, Sakari Ailus wrote:
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
>>>>  ?? - no update
>>>> v4:
>>>>  ?? - new
>>>> ---
>>>>  ? Documentation/media/uapi/v4l/pixfmt-reserved.rst | 12 ++++++++++++
>>>>  ? drivers/media/v4l2-core/v4l2-ioctl.c???????????? |? 1 +
>>>>  ? include/uapi/linux/videodev2.h?????????????????? |? 1 +
>>>>  ? 3 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/media/uapi/v4l/pixfmt-reserved.rst
>>>> b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
>>>> index b2cd155e691b..23c05063133d 100644
>>>> --- a/Documentation/media/uapi/v4l/pixfmt-reserved.rst
>>>> +++ b/Documentation/media/uapi/v4l/pixfmt-reserved.rst
>>>> @@ -264,6 +264,18 @@ please make a proposal on the linux-media
>>>> mailing list.
>>>>  ????? of tiles, resulting in 32-aligned resolutions for the luminance
>>>> plane
>>>>  ????? and 16-aligned resolutions for the chrominance plane (with 2x2
>>>>  ????? subsampling).
>>>> +??? * .. _V4L2-PIX-FMT-AJPG:
>>>> +
>>>> +????? - ``V4L2_PIX_FMT_AJPG``
>>>> +????? - 'AJPG'
>>>> +????? - ASPEED JPEG format used by the aspeed-video driver on Aspeed platforms,
>>>> +??????? which is generally adapted for remote KVM.
>>>> +??????? On each frame compression, I will compare the new frame with previous
>>>> +??????? one to decide which macroblock's data is changed, and only the changed
>>>> +??????? macroblocks will be compressed.
>>>> +
>>>> +??????? You could reference to chapter 36, Video Engine, of AST2600's datasheet
>>>> +??????? for more information.
>>> Is this datasheet publicly available? Do you have a URL?
>> Sorry, this datasheet is not publicly available.
>> Hans mentioned this as well in the discussion below:
>>
>> https://lkml.org/lkml/2021/11/10/101
> If questions come up during review, please also add the answers to the
> commit message of the next iteration. ;-) Maybe:
>
>> The implementation is based on datasheet *Name goes here*, revision
>> X, which is not publicly available.
> Kind regards,
>
> Paul

-- 
Best Regards
Jammy

