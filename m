From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 8 Dec 2021 04:02:22 +0000
Subject: [v14 0/2] Support pwm driver for aspeed ast26xx
In-Reply-To: <Ya/P+4CNTnUUqlG9@robh.at.kernel.org>
References: <20211130055933.32708-1-billy_tsai@aspeedtech.com>
 <CACPK8XfM4C7v3keXaxMs9SkqNzb8XWbZ6QvcZXWcy3ZKJCrvWQ@mail.gmail.com>
 <Ya/P+4CNTnUUqlG9@robh.at.kernel.org>
Message-ID: <ADD1E8B8-60F0-442A-BEF1-1AA304454963@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On 2021/12/8, 5:20 AM, "Rob Herring" <robh@kernel.org> wrote:

    On Tue, Dec 07, 2021 at 06:45:47AM +0000, Joel Stanley wrote:
    >   > Hi Billy,
    >   > 
    >   > On Tue, 30 Nov 2021 at 05:58, Billy Tsai <billy_tsai@aspeedtech.com> wrote:
    >   > >
    >   > > The legacy driver of aspeed pwm is binding with tach controller and it
    >   > > doesn't follow the pwm framworks usage. In addition, the pwm register
    >   > > usage of the 6th generation of ast26xx has drastic change. So these
    >   > > patch serials add the new aspeed pwm driver to fix up the problem above.
    >   > 
    >   > Sorry for not taking a look earlier. Well done on making it this far.
    >   > 
    >   > There's a few things that need to be addressed before merging this.
    >   > 
    >   > Firstly, the bindings need fixing up. I think these should be the one
    >   > file. The device tree bindings are supposed to describe the hardware,
    >   > and it doesn't make sense to separate them out just because we plan on
    >   > using two subsystems to implement the functionality.
    >   > 
    >   > Rob, please chime in if you would prefer something different.

    >   I prefer to see a common binding for fans which I said multiple times 
    >   on this series. As the same thing keeps getting posted, I've stopped 
    >   looking at this one.

Sorry to have bothered you so many times.
As I mention in v9:
"This patch doesn't use to binding the fan control h/w. It is used to binding the two independent h/w blocks.
One is used to provide pwm output and another is used to monitor the speed of the input.
It is different from "aspeed-pwm-tacho.txt" and "npcm750-pwm-fan.txt" which only focus on fan usage.
It is more like the "kontron,sl28cpld.yaml" the device includes a fan monitor and PWM output devices."
My purpose is to give more flexibility to our drivers and can use the existing driver "pwm-fan" to control
the fan instead of creating the code like XXX-pwm-fan to do the same thing.

Thanks

Best Regards,
Billy Tsai


