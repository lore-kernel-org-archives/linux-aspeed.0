From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 4 Oct 2021 01:46:01 +0000
Subject: [v9 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
In-Reply-To: <029CA29B-1488-4F73-A9E7-FB9BCD0B987F@aspeedtech.com>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-2-billy_tsai@aspeedtech.com>
 <20210713221431.GA936073@robh.at.kernel.org>
 <029CA29B-1488-4F73-A9E7-FB9BCD0B987F@aspeedtech.com>
Message-ID: <A7C9DA11-6880-46EC-BD71-2E1984EBA294@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On 2021/7/14, 12:02 PM, "Billy Tsai" <billy_tsai@aspeedtech.com> wrote:

    On 2021/7/14, 6:14 AM, "Rob Herring" <robh@kernel.org> wrote:

        On Fri, Jul 09, 2021 at 02:52:16PM +0800, Billy Tsai wrote:
        >>> This patch adds device binding for aspeed pwm-tach device which is a
        >>> multi-function device include pwm and tach function and pwm/tach device
        >>> bindings which should be the child-node of pwm-tach device.

        >>I'll say it again, the fan control h/w needs some common bindings for 
        >>describing fans and fan connections to pwm and tach. I'm not going to 
        >>sign off on more fan bindings just doing their own thing.

    > This patch doesn't use to binding the fan control h/w. It is used to binding the two independent h/w blocks.
    > One is used to provide pwm output and another is used to monitor the speed of the input.
    > It is different from "aspeed-pwm-tacho.txt" and "npcm750-pwm-fan.txt" which only focus on fan usage.
    > It is more like the "kontron,sl28cpld.yaml" the device includes a fan monitor and PWM output devices.

Can you give me more suggestions about this patch?

Thanks


