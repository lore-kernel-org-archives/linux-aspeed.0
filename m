From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri, 9 Apr 2021 02:38:38 -0500
Subject: [PATCH v5 2/4] drivers/tty/serial/8250: refactor sirq and lpc
 address setting code
In-Reply-To: <CAHp75Vd6kk0E-kALEGOhsg=YHKhmKLY6cpCTdviOFenO4p1-2A@mail.gmail.com>
References: <20210408011637.5361-1-zev@bewilderbeest.net>
 <20210408011637.5361-3-zev@bewilderbeest.net>
 <CAHp75Vd6kk0E-kALEGOhsg=YHKhmKLY6cpCTdviOFenO4p1-2A@mail.gmail.com>
Message-ID: <YHAEfn4li6F8L9JC@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 09, 2021 at 02:24:08AM CDT, Andy Shevchenko wrote:
>On Thursday, April 8, 2021, Zev Weiss <zev@bewilderbeest.net> wrote:
>
>> This splits dedicated aspeed_vuart_set_{sirq,lpc_address}() functions
>> out of the sysfs store functions in preparation for adding DT
>> properties that will be poking the same registers.  While we're at it,
>> these functions now provide some basic bounds-checking on their
>> arguments.
>>
>>
>
>Please, use prefix ?serial: 8250_aspeed_vuart:? instead of what you have in
>the subject line. I think I have told this already
>
>

Ah, sorry -- I fixed the cover letter after your first comment (which 
had definitely been under-tagged); for the patches themselves I was 
following the example of the last patch in that particular area 
(8d310c9107a2), though I guess that wasn't the right model to follow.  
I'll use the requested format in the future.


