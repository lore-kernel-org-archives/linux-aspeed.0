From: Andrew Jeffery <andrew@aj.id.au>
Date: Sat, 27 Aug 2022 08:18:33 +0930
Subject: [PATCH] pinctrl: aspeed: Force to disable the function's signal
In-Reply-To: <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
References: <20220818101839.28860-1-billy_tsai@aspeedtech.com>
 <CACRpkdYpp_1JJQmuX27pECxN0cjzciCuETLPTrSYKqpX0FPABQ@mail.gmail.com>
Message-ID: <e501d2fb-aaa0-470d-a8d5-5f8e97898df7@beta.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 27 Aug 2022, at 07:26, Linus Walleij wrote:
> On Thu, Aug 18, 2022 at 12:18 PM Billy Tsai <billy_tsai@aspeedtech.com> wrote:
>
>> When the driver want to disable the signal of the function, it doesn't
>> need to query the state of the mux function's signal on a pin. The
>> condition below will miss the disable of the signal:
>> Ball | Default | P0 Signal | P0 Expression               | Other
>> -----+---------+-----------+-----------------------------+----------
>>  E21   GPIOG0    SD2CLK      SCU4B4[16]=1 & SCU450[1]=1    GPIOG0
>> -----+---------+-----------+-----------------------------+----------
>>  B22   GPIOG1    SD2CMD      SCU4B4[17]=1 & SCU450[1]=1    GPIOG1
>> -----+---------+-----------+-----------------------------+----------
>> Assume the register status like below:
>> SCU4B4[16] == 1 & SCU4B4[17] == 1 & SCU450[1]==1
>> After the driver set the Ball E21 to the GPIOG0:
>> SCU4B4[16] == 0 & SCU4B4[17] == 1 & SCU450[1]==0
>> When the driver want to set the Ball B22 to the GPIOG1, the condition of
>> the SD2CMD will be false causing SCU4B4[17] not to be cleared.
>>
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>
> I can't see the verdict for this patch? Will there be a new
> version, or are we in the middle of a discussion?
> I'd really like Andrew's ACK on the result before merging.

Apologies, it's been a bit of A Week :)

Given the approach has been discussed with the IP designer and solves a bug I'm okay for it to be merged. If we run into issues it is easy enough to back it out.

Acked-by: Andrew Jeffery <andrew@aj.id.au>

>
> Yours,
> Linus Walleij
