From: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Date: Sun, 27 Mar 2022 13:24:14 -0700
Subject: [PATCH v3] ARM: dts: aspeed: add Nuvia DC-SCM BMC
In-Reply-To: <d0044322-72d8-1348-9898-dc91e3192e94@kernel.org>
References: <20220325190247.468079-1-quic_jaehyoo@quicinc.com>
 <d0044322-72d8-1348-9898-dc91e3192e94@kernel.org>
Message-ID: <92b381f7-6a4b-1db1-ea00-7bbc8c4b0f84@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


[...]

>> +	chosen {
>> +		stdout-path = &uart5;
>> +		bootargs = "console=ttyS4,115200n8";
> 
> After adding stdout-path, please remove bootargs.

Can I keep the default bootargs for a case if CONFIG_CMDLINE_FORCE
is enabled?

Best Regards,
Jae

> 
> Best regards,
> Krzysztof
