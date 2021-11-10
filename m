From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Wed, 10 Nov 2021 09:23:57 +0100
Subject: [PATCH v3 5/7] media: aspeed: Support aspeed mode to reduce
 compressed data
In-Reply-To: <fb546475-8e61-b847-67c4-466dee57b318@aspeedtech.com>
References: <20211022065539.12392-1-jammy_huang@aspeedtech.com>
 <20211022065539.12392-6-jammy_huang@aspeedtech.com>
 <75ea5824-e241-6548-bdc2-7ac9ec6346b6@xs4all.nl>
 <7d6ced4a-fea1-1163-40cb-65b4ea929a51@aspeedtech.com>
 <34ce1814-349b-d7a9-6118-341eea9ecf5f@xs4all.nl>
 <fb546475-8e61-b847-67c4-466dee57b318@aspeedtech.com>
Message-ID: <f62d9fce-cb0b-42f2-ff69-71e79dcd51a2@xs4all.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/11/2021 03:40, Jammy Huang wrote:
> Dear Hans,
> 
> On 2021/11/9 ?? 06:17, Hans Verkuil wrote:
>> On 11/9/21 2:56 AM, Jammy Huang wrote:
>>> Dear Hans,
>>>
>>> Thanks for your review.
>>>
>>> On 2021/11/8 ?? 05:09, Hans Verkuil wrote:
>>>> On 22/10/2021 08:55, Jammy Huang wrote:
>>>>> aspeed supports differential jpeg format which only compress the parts
>>>>> which are changed. In this way, it reduces both the amount of data to be
>>>>> transferred by network and those to be decoded on the client side.
>>>>>
>>>>> 4 new ctrls are added:
>>>>> * Aspeed JPEG Format: to control aspeed's partial jpeg on/off
>>>>>     0: standard jpeg, 1: aspeed jpeg
>>>> What exactly is 'aspeed jpeg'?
>>> 'aspeed jpeg' is aspeed proprietary compression format. It will compare
>>> the new frame
>>> with previous one to decide which macroblock's data is changed, and only
>>> the changed
>>> macroblock will be compressed. In this way, the amount of compressed data is
>>> significantly reduced. This is similar to the concept of I/P-frames of
>>> video compression.
>> Right, but that makes this a new vendor-specific pixelformat, not a control.
> OK, I will add a new vendor-specific pixelformat for this.
>>
>>> For example, the video is static in first 3 frames and then a object in
>>> the video moved in
>>> 4th frame.
>>>
>>>   ?? ???? Frame Content????? | ?? Standard??? |??? Aspeed
>>> -----------------------------------------------------------------------
>>> 1th??? ??? ? ?? ?? ????? ??? ??? ?? |??? Full??? ??? ?? ? | Full
>>> 2th??? identical with 1st ? |??? Full??? ??? ? ?? | ? none (only about
>>> 12 Bytes for header data)
>>> 3th??? identical with 1st?? |??? Full??? ??? ???? | ? none
>>> 4th??? a object moved ??? |??? Full??? ??? ???? |?? Only the Macroblocks
>>> that have data changed are compressed
>>>
>>> I have implemented a javascript aspeed decoder in novnc to support this
>>> format, but
>>> the performance isn't good enough. I am working on a web-assembly to
>>> improve it.
>> Is this format documented in a datasheet or something similar, ideally freely
>> available?
> This format is documented in ast2400/2500/2600's datasheet, but it's not 
> freely available.

OK. Make sure to document the new pixelformat in
Documentation/userspace-api/media/v4l/pixfmt-reserved.rst with a reference to where it
is defined in the datasheet.

If there is publicly available source code that converts it to 'normal' JPEG, then
a reference to that would be very nice as well.

>>
>>>>> * Aspeed Compression Mode: to control aspeed's compression mode
>>>>>     0: DCT Only, 1: DCT VQ mix 2-color, 2: DCT VQ mix 4-color
>>>>>     This is AST2400 only. It will adapt JPEG or VQ encoding method according
>>>>>     to the context automatically.
>>>> What exactly does this do?
>>>>
>>>> Is this very aspeed-specific, or could this be a standard JPEG control?
>>> Yes, this is aspeed-specific. Its compression algorithm is a modified
>>> JPEG algorithm.
>> Is this specific to the aspeed jpeg format, or also to the 'regular' jpeg format?
> 
> It's specific to the aspeed jpeg format. Regular jpeg is based on DCT 
> and doesn't support VQ
> compression

OK, that makes it an aspeed-specific control. Good to know.

Regards,

	Hans
