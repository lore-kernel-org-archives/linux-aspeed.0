From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 3 Nov 2021 18:48:32 -0700
Subject: [PATCH -next 0/4] Add LCLK control into Aspeed LPC sub drivers
In-Reply-To: <768252cc-2466-3b4b-9087-549b83e00a81@linux.intel.com>
References: <20211101233751.49222-1-jae.hyun.yoo@intel.com>
 <CACPK8XfBi+jY5ftLqsEVXHe01SQBNpTSwo+WtXN3=YUQnXACtw@mail.gmail.com>
 <YYHSHoELvKRI4Zh1@hatter.bewilderbeest.net>
 <d2a18e3b-cb02-37b5-cad8-45c3e8ff3bb4@linux.intel.com>
 <YYHYMKDD7hz15ceR@hatter.bewilderbeest.net>
 <63678f47-8b4a-1385-a755-bc7c2316ca0d@linux.intel.com>
 <YYHhMGm4C0srTW1x@hatter.bewilderbeest.net>
 <768252cc-2466-3b4b-9087-549b83e00a81@linux.intel.com>
Message-ID: <YYM78OxYMYwiFzWD@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 03, 2021 at 08:56:10AM PDT, Jae Hyun Yoo wrote:
>
>Hi Zev,
>
>Not sure but looks like one of LPC functions is enabled while kernel
>booting. 
>

Looks like that was exactly the clue I needed -- obvious in retrospect, 
but I realize now that I'm only seeing this happen when I bypass the 
normal shutdown sequence via 'reboot -f'; with a plain 'reboot' I don't 
hit any problems.  Can you reproduce it that way?


Zev

