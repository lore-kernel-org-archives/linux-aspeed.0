From: Zev Weiss <zev@bewilderbeest.net>
Date: Tue, 11 Jan 2022 17:14:38 -0800
Subject: [PATCH] ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC
In-Reply-To: <CACPK8XeHyoo0D1vQm=L8m284kC5n-O+FEMp1HN+ROWJfx7qjhQ@mail.gmail.com>
References: <20220105101719.7093-1-zev@bewilderbeest.net>
 <CACPK8XeHyoo0D1vQm=L8m284kC5n-O+FEMp1HN+ROWJfx7qjhQ@mail.gmail.com>
Message-ID: <Yd4rfi/iICQ5EjGh@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 11, 2022 at 02:59:28AM PST, Joel Stanley wrote:
>On Wed, 5 Jan 2022 at 23:10, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> This is a half-width, single-socket Epyc server board with an AST2500
>> BMC.  This device tree is sufficient for basic OpenBMC functionality,
>> but we'll need to add a few more devices (as driver support becomes
>> available) before it's fully usable.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
>Reviewed-by: Joel Stanley <joel@jms.id.au>
>

Thanks!

>Have you considered using the openbmc gpio naming scheme for the
>gpio-line-names?
>

I looked at it, but decided not to for a few reasons:

  - For systems that are in the early stages of a porting effort (like 
    this one currently is), I'm still referring to hardware schematics 
    fairly often, and using the same identifiers in software that are 
    used in the schematics simplifies things by avoiding an extra
    translation step between the two.

  - Most of the GPIO-related userspace components (that I'm dealing with 
    anyway, e.g. x86-power-control and host-error-monitor) already have 
    their own GPIO line-name configuration/remapping mechanisms that need 
    to be set up anyway.

  - There's a solid mix of GPIOs that would be covered by the naming 
    guidelines and others that aren't; having a mix of the two styles 
    seems a bit awkward to me.

That said, I sympathize with the motivation behind it and I'm not 
vehemently opposed on the whole, so if there's a strong preference to 
follow that scheme I could probably be talked into changing it.


Zev

