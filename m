From: Matthias Brugger <matthias.bgg@gmail.com>
Date: Tue, 29 Mar 2022 12:06:38 +0200
Subject: [RFC PATCH 0/1] Categorize ARM dts directory
In-Reply-To: <YkLXTWdZ3zASxr4H@atomide.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <CAFr9PXkgrRe-=E=GhNnZ4w1x_FMb97-_RmX6ND1vEd74_TbZSw@mail.gmail.com>
 <YkK691VG6ON/6Ysn@atomide.com>
 <CAMuHMdXDDNTgBdJTa8+H1H5v1gAarp07xxWu_E1JL8mXS8HPMg@mail.gmail.com>
 <YkLXTWdZ3zASxr4H@atomide.com>
Message-ID: <6dafde7d-17c6-bd25-dbe8-7f7acf80fd91@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 29/03/2022 11:54, Tony Lindgren wrote:
> * Geert Uytterhoeven <geert@linux-m68k.org> [220329 09:02]:
>> On Tue, Mar 29, 2022 at 10:03 AM Tony Lindgren <tony@atomide.com> wrote:
>>> For example, I have a pile of pending omap clock clean-up dts patches
>>> posted and tested waiting for v5.19-rc1 to apply. I'd rather not start
>>> redoing or fixing up the patches with sed :)
>>
>> Git merge/rebase/cherry-pick should handle renames fine?
> 
> Possibly.. Not sure I'd count on that based on my earlier experiences
> though :)
> 

Yes. If this could be split up in per silicon-vendor patches, the maintainer 
could take them. Although it might be a pain to soc maintainers to resolve small 
conflicts when merging that branches.

Just my 5 cents.

Matthias
