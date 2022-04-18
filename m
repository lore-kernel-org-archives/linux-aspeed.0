From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 18 Apr 2022 07:07:36 -0700
Subject: [PATCH v3 0/7] Fix AST2600 quad mode SPI pinmux settings
In-Reply-To: <CACRpkdZff-TbnNHO6Q590ubyH51+yqN68DOghazVKvYoHMBekw@mail.gmail.com>
References: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
 <CACRpkdZff-TbnNHO6Q590ubyH51+yqN68DOghazVKvYoHMBekw@mail.gmail.com>
Message-ID: <697daba9-c07d-5a41-305e-95b1dcfa1c50@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Linus,

On 4/17/2022 4:28 PM, Linus Walleij wrote:
> Hi Jae,
> 
> On Tue, Mar 29, 2022 at 7:40 PM Jae Hyun Yoo <quic_jaehyoo@quicinc.com> wrote:
> 
>> Jae Hyun Yoo (5):
>>    pinctrl: pinctrl-aspeed-g6: remove FWQSPID group in pinctrl
>>    dt-bindings: pinctrl: aspeed-g6: remove FWQSPID group
>>    dt-bindings: pinctrl: aspeed-g6: add FWQSPI function/group
>>    pinctrl: pinctrl-aspeed-g6: add FWQSPI function-group
> 
> These four patches applied to the pinctrl tree.
> 
> Please funnel patches 1, 6, 7 through the SoC tree.

Thanks a lot!

Hi Joel,
Can you please include 1, 6 and 7 in the next pull request of Aspeed
SoC tree?

Thanks,
Jae
