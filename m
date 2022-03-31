From: Zev Weiss <zweiss@equinix.com>
Date: Thu, 31 Mar 2022 06:08:45 +0000
Subject: [PATCH 2/2] ARM: dts: aspeed: romed8hm3: Fix GPIOB0 name
In-Reply-To: <CACPK8XeeFDSN8L89BPkV+UfGTYNiULyUPBTYso7Z7e+VEdgc4A@mail.gmail.com>
References: <20220331022425.28606-1-zev@bewilderbeest.net>
 <20220331022425.28606-2-zev@bewilderbeest.net>
 <CACPK8XeeFDSN8L89BPkV+UfGTYNiULyUPBTYso7Z7e+VEdgc4A@mail.gmail.com>
Message-ID: <20220331060844.GE24501@packtop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 30, 2022 at 10:35:47PM PDT, Joel Stanley wrote:
>On Thu, 31 Mar 2022 at 02:24, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> This GPIO was mislabeled as DDR_MEM_TEMP in the schematic; after a
>> correction from ASRock Rack its name now reflects its actual
>> functionality (POST_COMPLETE_N).
>
>Those are quite different functions :)
>

Yes, rather -- that little tidbit resolved quite a bit of
head-scratching that had been going on...

>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
>Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")

Ah yes, I'll try to remember to include those to start with.

>Reviewed-by: Joel Stanley <joel@jms.id.au>
>
>I'll send some fixes in after -rc1.
>

Thanks!

Zev
