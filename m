From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 30 Mar 2022 12:37:48 +1030
Subject: aspeed2500 SPI1 control at run-time with OpenBMC
In-Reply-To: <CAFPZpNZ1+UDVcEs_gp1zCzxXfP6PqZ8kx+UGhb73BusiScRk+g@mail.gmail.com>
References: <CAFPZpNbNc5Fx1tBtmM1x0n-qEB_qp+wSSrR2+_0bxPrPyh1xMw@mail.gmail.com>
 <c29de2ea-0f60-4e7f-8308-11849a7de8e8@www.fastmail.com>
 <CAFPZpNZ1+UDVcEs_gp1zCzxXfP6PqZ8kx+UGhb73BusiScRk+g@mail.gmail.com>
Message-ID: <a509d7a3-2551-4eea-b965-9499ada39b16@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 30 Mar 2022, at 04:27, Ali El-Haj-Mahmoud wrote:
> Thanks for the reply Andrew.
>
>> Not explicitly as I mentioned. You're also going to run into the
>> constraints here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c?h=v5.17#n2739
>>
>> Fundamentally that needs to be changed. We could do something like have
>> it default to pass-through unless a driver is bound.
>
> Could you please elaborate on this a bit? I'm way out of my depth here
> and would appreciate any additional pointers.
>
> I already ran into the read-only constraints in the pinctrl driver,
> and I have a patch that excludes SCU70[13:12], but that wasn't enough.

What were you doing to test it?
