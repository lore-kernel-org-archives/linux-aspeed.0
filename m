From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 01 Aug 2022 13:55:26 +0930
Subject: aspeed2500 SPI1 control at run-time with OpenBMC
In-Reply-To: <CABoTLcSj0Py37E9tjC=0snep71Hg2bvTG8oGm_+wmiUHpTZL5w@mail.gmail.com>
References: <CAFPZpNbNc5Fx1tBtmM1x0n-qEB_qp+wSSrR2+_0bxPrPyh1xMw@mail.gmail.com>
 <c29de2ea-0f60-4e7f-8308-11849a7de8e8@www.fastmail.com>
 <CAFPZpNZ1+UDVcEs_gp1zCzxXfP6PqZ8kx+UGhb73BusiScRk+g@mail.gmail.com>
 <a509d7a3-2551-4eea-b965-9499ada39b16@www.fastmail.com>
 <CAFPZpNb4fNF-QgQrWLeSkN9TjYsWZvH1YrbQj66rBW6jn8rCug@mail.gmail.com>
 <CABoTLcSj0Py37E9tjC=0snep71Hg2bvTG8oGm_+wmiUHpTZL5w@mail.gmail.com>
Message-ID: <e94ec2a3-cb7e-4e8b-bb73-fe6b7a6c618d@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 31 Mar 2022, at 07:40, Oskar Senft wrote:
>> I can
>> switch SPI1 control to master through pinmux-select:
>> [...]
>>
>> However, I cannot access the device. '/dev/mtd6' doesn't exist, and I
>> cannot bind it:
>> $  echo 1e630000.spi >/sys/bus/platform/drivers/aspeed-smc/bind
>> -sh: echo: write error: No such file or directory
>
> Is there an existing interaction (in the code) between the Aspeed SPI
> driver and pinmux? I guess ideally we'd want the SPI driver to talk
> with pinmux to tell it "I'd like to bind the device, can you please
> configure the pins properly" as well as "I just unbound the device.
> pinmux, please release the pins".
>
> With that, I wonder if we somewhat have that already and "pinctrl-0 =
> <&pinctrl_spi1passthru_default>" ends up "confusing" the link between
> the pinmux and the spi driver (since it's actually the opposite of
> what we want)? How is that _supposed_ to work? Maybe there's just a
> bug?

Possibly, getting a driver going for the Aspeed pinmux is hard work :)

>
> Also, I'm wondering: Is it possible to have "&spi1" defined, but not
> bound initially? I guess that's what we want by default?

Zev tried this and got a lot of push-back.

https://lore.kernel.org/all/20211022020032.26980-1-zev at bewilderbeest.net/

Andrew
