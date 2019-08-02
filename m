From: Tao Ren <taoren@fb.com>
Date: Fri, 2 Aug 2019 03:56:11 +0000
Subject: [PATCH] ARM: dts: aspeed: Add Facebook Wedge100 BMC
In-Reply-To: <CACPK8XdS4m9+74oxK0-ed3ZLr_QCh--AsFgGcF-OpLw24v9g4Q@mail.gmail.com>
References: <20190802010155.489238-1-taoren@fb.com>
 <CACPK8XdS4m9+74oxK0-ed3ZLr_QCh--AsFgGcF-OpLw24v9g4Q@mail.gmail.com>
Message-ID: <0862C896-35D3-4032-8DA8-E4B7632CC333@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 8/1/19, 8:02 PM, "Joel Stanley" <joel@jms.id.au> wrote:

>  On Fri, 2 Aug 2019 at 01:02, Tao Ren <taoren@fb.com> wrote:
>> +
>> +       chosen {
>> +               stdout-path = &uart3;
>> +               bootargs = "debug console=ttyS2,9600n8 root=/dev/ram rw";
>  
>  Are you sure you want 'debug' in your boot arguments?
> 
> The rest lgtm. I can remove debug when applying, or leave it there if
> it was intentional.

Ahh, I copied bootargs from "/proc/cmdline" on my machine (running old kernel) but I don't think I need it.

Thank you for pointing it out. Let me send out v2 patches in a few minutes (so you could apply without extra changes).


Cheers,

Tao
    

