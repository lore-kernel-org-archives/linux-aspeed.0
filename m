From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Thu, 24 Mar 2022 14:27:34 -0700
Subject: [PATCH] ARM: dts: aspeed: add Nuvia DC-SCM BMC
In-Reply-To: <YjzhT4gOJ9SKy6q+@lunn.ch>
References: <20220324164551.359570-1-quic_jaehyoo@quicinc.com>
 <YjzhT4gOJ9SKy6q+@lunn.ch>
Message-ID: <88849423-c4a5-0a68-1900-72196395704e@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 3/24/2022 2:23 PM, Andrew Lunn wrote:
> On Thu, Mar 24, 2022 at 09:45:51AM -0700, Jae Hyun Yoo wrote:
>> From: Graeme Gregory <quic_ggregory@quicinc.com>
>>
>> +&mac2 {
>> +	status = "okay";
>> +
>> +	phy-mode = "rgmii";
> 
> Are you sure about this? That PHY are you using? It is more normal to
> use rgmii-id.

Yes, I'm sure. PHY works with rgmii on my board. I picked a different
clock delay setting too.

Thanks,
Jae

