From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 23 Jun 2022 09:10:34 +0200
Subject: [PATCH 2/7] dt-bindings: arm: aspeed: document board compatibles
In-Reply-To: <CACPK8Xc=dmaJtLXGsQa8bBdWDnSbwyW3f_yaQr4HqT0WvyScRg@mail.gmail.com>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-2-krzysztof.kozlowski@linaro.org>
 <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
 <CACPK8Xc=dmaJtLXGsQa8bBdWDnSbwyW3f_yaQr4HqT0WvyScRg@mail.gmail.com>
Message-ID: <bd070c5d-4765-092d-8f10-fefd0361f65e@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 23/06/2022 07:36, Joel Stanley wrote:
> On Mon, 20 Jun 2022 at 11:06, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 29/05/2022 12:49, Krzysztof Kozlowski wrote:
>>> Document all compatibles used in existing upstreamed Aspeed AST2400,
>>> AST2500 and AST2600 based boards.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  .../bindings/arm/aspeed/aspeed.yaml           | 83 +++++++++++++++++++
>>>  MAINTAINERS                                   |  1 +
>>>  2 files changed, 84 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>>
>> Joel, Andrew,
>>
>> Any comments on the series? Rob applied only patch 1, so the rest is
>> supposed through Aspeed tree. Shall I pick them up and send to arm-soc?
> 
> I will take a look at them when it's time to send patches for the next
> kernel release.

But that's not how the next development works. Patches, if proper/good,
should be applied in some reasonable amount of time and then sit in
maintainers tree. This way the patches will be in linux-next, assuming
that maintainer correctly added it to linux-next. All other people can
then easily base their work on linux-next or maintainer's tree and
continue their development.

Waiting with the patches till time to intreract with arm-soc (usually
some late in the cycle, like rc5-rc6), not providing review, does not
allow other people to see accepted contributions and base the work on them.

Really, there is no single reason to hold on patches till there is time
to send them to arm-soc. It's the first time I hear something like this
about SoC or any other tree.

> 
> They should go through the aspeed tree like the rest of the aspeed
> device tree patches.

Of course, but somehow they were not going...

Best regards,
Krzysztof
