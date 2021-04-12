From: Zev Weiss <zev@bewilderbeest.net>
Date: Sun, 11 Apr 2021 21:42:39 -0500
Subject: [PATCH v3] ARM: dts: aspeed: add ASRock E3C246D4I BMC
In-Reply-To: <CACPK8XcfuEyqGmO72taXFPARxwzLyct5__0C0CF-nyEf6Yubnw@mail.gmail.com>
References: <20210401044232.9637-1-zev@bewilderbeest.net>
 <84202973-1a94-4630-beeb-f33d044a0364@www.fastmail.com>
 <CACPK8XcfuEyqGmO72taXFPARxwzLyct5__0C0CF-nyEf6Yubnw@mail.gmail.com>
Message-ID: <YHOznzolgu+j9Ruh@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Apr 11, 2021 at 09:20:59PM CDT, Joel Stanley wrote:
>On Mon, 12 Apr 2021 at 02:16, Andrew Jeffery <andrew@aj.id.au> wrote:
>> On Thu, 1 Apr 2021, at 15:12, Zev Weiss wrote:
>
>> > +&vuart {
>> > +     status = "okay";
>> > +     aspeed,sirq-active-high;
>>
>> This should probably go away, but otherwise,
>
>Zev, this has already been merged (both to mainline for v5.13 and in
>openbmc), so any fixups need to come as patches on top of the existing
>code.
>

Got it, thanks -- I figured I'd wait until the DT-properties patches got 
approved & merged (I'll be sending v6 of that shortly) and then send an 
incremental update for the e3c246d4i dts to match the final form of 
those.


Zev

