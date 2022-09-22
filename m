From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 22 Sep 2022 08:52:10 +0200
Subject: [PATCH v4 2/2] ARM: dts: aspeed: Add AMD DaytonaX BMC
In-Reply-To: <CACSj6VWg+QfSYqeeUR5vtgJFLJg5us5-=D_Esj5NK-uvtH2B3g@mail.gmail.com>
References: <20220920165404.14099-1-aladyshev22@gmail.com>
 <20220921210950.10568-1-aladyshev22@gmail.com>
 <20220921210950.10568-3-aladyshev22@gmail.com>
 <CACSj6VWg+QfSYqeeUR5vtgJFLJg5us5-=D_Esj5NK-uvtH2B3g@mail.gmail.com>
Message-ID: <6f727f9b-aa1a-3eba-87ec-3e36eeb15351@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/09/2022 23:15, Konstantin Aladyshev wrote:
> Sorry, I still have some questions, can you please help me?
> 
> I work with kernel in the context of the OpenBMC project, and it is
> not possible to run 'make dtbs_check' in the linux kernel devshell
> (Yocto). So I've tried to download upstream kernel and have performed
> the following commands to make the dtbs_check:
> ```
> $ make ARCH=arm aspeed_g5_defconfig && make ARCH=arm dtbs_check
> ```
> This gave me a ton of output regarding all the problems in all of the
> aspeed boards. 'wc -l' says that the log file is about 7080 lines
> long. Is it possible to get the output only for my target DTS? The
> article that you've referred to
> (https://www.kernel.org/doc/Documentation/devicetree/writing-schema.rst)
> only have the information about how to run checks against one schema
> (DT_SCHEMA_FILES), but it is not the same thing.

You can limit it per target. See slide 11:
https://osseu2022.sched.com/event/15z0W

This might miss some warnings, so better way is to:
make ARCH=arm dtbs_check
touch your-dts
make ARCH=arm dtbs_check

You will get only your errors.

> 
> I've manually tried to split the output regarding my DTS file, but
> even so the output is overwhelming - https://pastebin.com/b92rnBt0. I
> just don't understand if the mentioned things are about the common
> "aspeed-g5.dtsi" file that I should ignore or the things regarding
> errors in my submitted DTS file. Can you give me some advice on that?

Yes, you can ignore errors from dtsi.

Best regards,
Krzysztof

