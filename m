From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 05 Apr 2023 14:45:14 +0930
Subject: [PATCH v3 0/3] i3c dw,ast2600: Add a driver for the AST2600 i3c controller
In-Reply-To: <CACPK8XcPBCppbF8smOsO3csiWoomgheLHcudyNON3QDrwyguOw@mail.gmail.com>
References: <20230331091501.3800299-1-jk@codeconstruct.com.au>
 <CACPK8XdLpg2H4a2nHo4PokfBc4r3D8MbK2-62jXkPXAq8Q03Rg@mail.gmail.com>
 <94e941a2895bbb40d7b87acd7de6525b8596b096.camel@codeconstruct.com.au>
 <CACPK8XcPBCppbF8smOsO3csiWoomgheLHcudyNON3QDrwyguOw@mail.gmail.com>
Message-ID: <4da7a1d9-3047-453c-8a94-16f6ab524e57@betaapp.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 5 Apr 2023, at 14:26, Joel Stanley wrote:
> On Wed, 5 Apr 2023 at 04:34, Jeremy Kerr <jk@codeconstruct.com.au> wrote:
>>
>> Hi Joel,
>>
>> > Given we have acks on the bindings, I think it's safe to send the
>> > device tree changes now so we can merge what you have in the upcoming
>> > merge window. If there's changes we can modify or revert.
>>
>> OK, I'll get those into shape.
>>
>> There is one dependency on this though, and unfortunately it requires
>> solving *two* of the known-hard problems in computer science:
>>
>> Do we start at i3c0 or i3c1?
>
> I'd vote for i3c0, like we do for ethernet, i2c, spi, etc.
>
> It is annoying that aspeed chooses to start counting at 1, but at
> least we would be consistent with other parts of the kernel.
>
> Starting at 1 reminds me of doing matlab assignments at uni, so that's
> another reason to avoid it.

I've heard rumors that Aspeed will number their devices from zero in the future :)

Andrew
