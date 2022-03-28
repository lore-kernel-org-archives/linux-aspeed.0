From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Mon, 28 Mar 2022 07:15:06 -0700
Subject: [PATCH v3] ARM: dts: aspeed: add Nuvia DC-SCM BMC
In-Reply-To: <94377113-b51d-8fb2-56fe-6f2abcea8ed0@kernel.org>
References: <20220325190247.468079-1-quic_jaehyoo@quicinc.com>
 <d0044322-72d8-1348-9898-dc91e3192e94@kernel.org>
 <92b381f7-6a4b-1db1-ea00-7bbc8c4b0f84@quicinc.com>
 <94377113-b51d-8fb2-56fe-6f2abcea8ed0@kernel.org>
Message-ID: <979a5c87-a7ea-a1f0-e42e-29043df6b348@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/28/2022 12:13 AM, Krzysztof Kozlowski wrote:
> On 27/03/2022 22:24, Jae Hyun Yoo wrote:
>>
>> [...]
>>
>>>> +	chosen {
>>>> +		stdout-path = &uart5;
>>>> +		bootargs = "console=ttyS4,115200n8";
>>>
>>> After adding stdout-path, please remove bootargs.
>>
>> Can I keep the default bootargs for a case if CONFIG_CMDLINE_FORCE
>> is enabled?
> 
> No, because you control the config, so just disable CMDLINE_FORCE if you
> don't want it and such bootargs are not part of hardware description.

Okay, I'll remove bootargs in v4. Thanks!

Best Regards,
Jae
