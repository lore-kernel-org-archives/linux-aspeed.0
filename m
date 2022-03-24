From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Thu, 24 Mar 2022 15:40:26 -0700
Subject: [PATCH] ARM: dts: aspeed: add Nuvia DC-SCM BMC
In-Reply-To: <Yjzub26okJosPkXC@lunn.ch>
References: <20220324164551.359570-1-quic_jaehyoo@quicinc.com>
 <YjzhT4gOJ9SKy6q+@lunn.ch> <88849423-c4a5-0a68-1900-72196395704e@quicinc.com>
 <Yjzub26okJosPkXC@lunn.ch>
Message-ID: <a70bde19-3ded-d8ae-51ff-ec37fa803b06@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/24/2022 3:19 PM, Andrew Lunn wrote:
> On Thu, Mar 24, 2022 at 02:27:34PM -0700, Jae Hyun Yoo wrote:
>> Hi Andrew,
>>
>> On 3/24/2022 2:23 PM, Andrew Lunn wrote:
>>> On Thu, Mar 24, 2022 at 09:45:51AM -0700, Jae Hyun Yoo wrote:
>>>> From: Graeme Gregory <quic_ggregory@quicinc.com>
>>>>
>>>> +&mac2 {
>>>> +	status = "okay";
>>>> +
>>>> +	phy-mode = "rgmii";
>>>
>>> Are you sure about this? That PHY are you using? It is more normal to
>>> use rgmii-id.
>>
>> Yes, I'm sure. PHY works with rgmii on my board. I picked a different
>> clock delay setting too.
> 
> Do you know who is inserting the delay? It looks like rgmii will be
> passed to the PHY. So there are few possibilities here:
> 
> The MAC is adding the delay. Not recommended, but does work. In that
> case, your DT is correct.
> 
> The bootloader or strapping configures the PHY to insert the
> delay. The PHY driver then ignores 'rgmii' and leaves the
> configuration alone. This will break sometime in the future when
> somebody fixes the PHY driver to actually set the PHY to rgmii as
> requested. In this case, both the PHY driver and your DT is broken.
> 
> The board itself inserts the delays by having long tracks. In this
> case, your DT is correct.
> 
> It would be good to understand this, just in case it is the second
> condition.

Thanks for your kind explanation.

The clock delay I mentioned is added into u-boot bootloader in a
patch I'm currently trying to submit.
https://lore.kernel.org/all/20220324165530.359668-1-quic_jaehyoo at quicinc.com/

I had to pick those value with 'rgmii' to make my board work but the
delay is actually different from what AST2600 EVB DT provides. I think
it's caused by a different PCB routing and board characteristic like
you said.

I want to keep this setting as it's acquired from lots of experiments.
It could be changed in case if it needs to be fixed in the future.

Thanks,
Jae
