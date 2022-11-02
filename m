From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 2 Nov 2022 03:21:21 +0000
Subject: [v2 1/3] dt-bindings: Add bindings for aspeed pwm-tach.
In-Reply-To: <20221101184033.GA1879756-robh@kernel.org>
References: <20221101095156.30591-1-billy_tsai@aspeedtech.com>
 <20221101095156.30591-2-billy_tsai@aspeedtech.com>
 <20221101184033.GA1879756-robh@kernel.org>
Message-ID: <C4090559-71D3-4DC4-A994-474D375DC4EF@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Rob,

On 2022/11/2, 2:40 AM, "Rob Herring" <robh@kernel.org> wrote:

  >  On Tue, Nov 01, 2022 at 05:51:54PM +0800, Billy Tsai wrote:
  >  > This patch adds device binding for aspeed pwm-tach device which is a
  >  > multi-function device include pwm and tach function and pwm/tach device
  >  > bindings which should be the child-node of pwm-tach device.
  >  > 
  >  > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
  >  > ---
  >  >  .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 48 ++++++++++++
  >  >  .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 76 +++++++++++++++++++
  >  >  .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 64 ++++++++++++++++
  >  >  3 files changed, 188 insertions(+)
  >  >  create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
  >  >  create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
  >  >  create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml

  >  I'm pretty sure I've said this before, but I'm not taking more fan 
  >  controller bindings without comming up with a common binding. Please see 
  >  this series[1] and help ensure it meets your needs.

  >  Rob

  >  [1] 20221013094838.1529153-2-Naresh.Solanki at 9elements.com <https://lore.kernel.org/all/<a href=>/">https://lore.kernel.org/all/20221013094838.1529153-2-Naresh.Solanki at 9elements.com/

The link you provide doesn't meet my needs. This is fan binding.
As I told before 
"This patch doesn't use to binding the fan control h/w. It is used to binding the two independent h/w blocks.
One is used to provide pwm output and another is used to monitor the speed of the input." 
My patch is used to point out that the pwm and the tach is the different function and don't need to
bind together. You can not only combine them as the fan usage but also treat them as the individual module for
use. For example: the pwm can use to be the beeper (pwm-beeper.c), the tach can be used to monitor any device's speed.

Thanks

Best Regards,
Billy Tsai

