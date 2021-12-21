From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Tue, 21 Dec 2021 10:13:34 +0800
Subject: [PATCH v5 00/10] add aspeed-jpeg support for aspeed-video
In-Reply-To: <YcDfl9V1oJFMebfF@paasikivi.fi.intel.com>
References: <20211118074030.685-1-jammy_huang@aspeedtech.com>
 <5ab806d1-e407-1fa4-83ec-93ebe8df7db4@xs4all.nl>
 <b6ba49f3-a9ed-f5e6-959c-309db8cce7f6@aspeedtech.com>
 <6e0da74e-ddce-3c94-42a1-f98833489d60@xs4all.nl>
 <549aaf9a-cd72-e200-0329-30f6c71b8ed7@aspeedtech.com>
 <e61856d5-c371-ab52-2814-d0d8aabee0f0@aspeedtech.com>
 <YcDfl9V1oJFMebfF@paasikivi.fi.intel.com>
Message-ID: <d9dc2375-e4a8-9bb2-bb70-7104fa8186a7@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Sakari,

On 2021/12/21 ?? 03:55, sakari.ailus at linux.intel.com wrote:
> Hi Jammy,
>
> On Tue, Dec 07, 2021 at 11:03:00AM +0800, Jammy Huang wrote:
>> Hi Hans,
>>
>> The implementation of decoder for this format as been available here.
>> https://github.com/AspeedTech-BMC/aspeed_codec
> The format documentation should point to this, as well as other
> documentation there is.
OK, I will add this into format documentation as well.
>
> I'm not sure there have been specific requirements of license, but it's the
> first time I see MPL 2.0 being used in such context. It's eventually
> convertible to GPL (or LGPL) although the route is inconvenient at best.
> Or would people be happy with MPL code in v4l-utils?

In order to have aspeed-jpeg format to work on openbmc's KVM, I was 
working on noVNC.
And this codec library is part of the code to make it work.

Before I put this source on github, I am not sure which kind of license 
is suitable. So I check
what noVNC used, https://github.com/novnc/noVNC/blob/master/LICENSE.txt. 
That's why I
adapted MPL 2.0.

If you think GPL(or LGPL) is more suitable, I can make a switch.


>
> I wonder what others think.
>
-- 
Best Regards
Jammy

