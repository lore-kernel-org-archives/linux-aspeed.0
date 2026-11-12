Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD51606A336
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Nov 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c9NRZP1X
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQRBX6Cwjz30dn;
	Fri, 13 Nov 2026 03:47:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794502036;
	cv=none; b=BKu9i8EJURudPiIS81vuVw50EciWPjAv4ReaG7Xw7yoEeVmDvWc4LfpitYhxc89jgx/18QxJEEQTLjYVkcY2F+cl/XmytIcnuUSMlQAzQdKUywfp824SM28y7t8EXP4GgBrGASiZlEfNGT+jwhUV2ZgbLOHr+7Jhy98x1tuNnP6cq/n/VoVXQIIIim/KLAWZYvyxutXhfNZJm+/+kYQD5ZfKGMuFXRti09X0B5iRjne/7d0/vYEh/bbkL2F/kcL9RvVv3RUoc0lA2td+czkEn15VgTqGNZ61rXs8MGk5SftD7FSAY4G53C7/64JbWlBUYk9V0Kl9IR004jEDBYhH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794502036; c=relaxed/relaxed;
	bh=EI+/gOi3YcwXHjbf8KM4BWSUOlp+RtEEWptAHvG91Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECk/oN2F6F4Dj1l2vBc8iQu4GNANf/SocXSHoZlgm/q1NhsYvAr8+Tzmq19yAO3Cnk9LweSiG5F7uX6jYyFyqDrQwOxs+4qA0l5IHIg6OxIg7BGnWEK92DP95+hwbbSYPWCWQARxHq8Jd/WZuAE2PyKhSt1XhCIRIuUwmIqE6jhPgiUvRXSSef1Wc8IIZ9tT/xl8UORBjPpChqMfbmVtqm5UHWKSOW9vKirbGZRPA5edDi6BIgfzUCykl87RDWkdXjD3hFwSa+Kxf1hEr5W8x2GXRmm7rlJQa5ZVl5Bu65/Yw4b5brWHypcDrSKF/yH7Y8CaHLUkmLw952Jiq8WFkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c9NRZP1X; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c9NRZP1X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQRBT6fYvz30WS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Nov 2026 03:47:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794502035; x=1826038035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gb+ertXw9oZUZYFRwrzAW9mTO6w0J+Qo9JE40Aj9z54=;
  b=c9NRZP1XmdGrNSOkmwC1KcYcAV6KNS7SWQb3VF/IuapQS9nnqWjSsUbd
   B5x27jIYb7cpuemjRAZT3qh+FZmbP7JQJtY+8+dV1lEh6zYFCSZFXSkAs
   1HYbE9zgkjTgHIMOcoTahDkq/LnRDRI+te268+wirt2ZkW0WwYA6iA/J/
   YIDum/cO3Y0ZVk+DSS2D/fKGqyynNO7A1NnBtIMMNi/rrV7W3W2LxgwiM
   lrn0bQjllp5s96t81PXrEpOpGXAZii7zv+uRDBEUo0+vwNOerHeVp3hCv
   qzsTzRCKWMXleZNAvaSwJgdiAJi+GGvR4ha+ZI4rDTXk4GRAxXCCXOAm9
   w==;
X-CSE-ConnectionGUID: KulDFw8OQOKLmjd09rRIfw==
X-CSE-MsgGUID: Hmo0uGdIS8m8Jzts2oJ5dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3176597"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3176597"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:47:06 -0800
X-CSE-ConnectionGUID: lzK5vqr6QuuygsvCO9xHyw==
X-CSE-MsgGUID: fvngpodqSqOyq1wRmPy0EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8699912"
Received: from dawidgla-mobl.ger.corp.intel.com (HELO [10.246.19.71]) ([10.246.19.71])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:47:03 -0800
Message-ID: <d246fbef-d923-475c-8e1f-bbeca20847e7@linux.intel.com>
Date: Thu, 12 Nov 2026 17:47:00 +0100
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] ARM: dts: aspeed: Add Intel AVCRP BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maciej.lawniczak@intel.com, Andrew Lunn <andrew@lunn.ch>
References: <cover.1794242015.git.dawid.glazik@linux.intel.com>
 <ee6958ba4b93cde4719fbac89c4027964c2236bc.1794242015.git.dawid.glazik@linux.intel.com>
 <fff90721f7892c0285f4fed7fed460c7c1e183cb.camel@codeconstruct.com.au>
 <599f1b31-f175-47df-b074-1915688eb390@linux.intel.com>
 <a92395610d27fc0f97af3b27b150de61583c2197.camel@codeconstruct.com.au>
Content-Language: en-US
From: Dawid Glazik <dawid.glazik@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <a92395610d27fc0f97af3b27b150de61583c2197.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 2:49 AM, Andrew Jeffery wrote:
> On Tue, 2026-11-10 at 17:42 +0100, Dawid Glazik wrote:
>> On 11/10/2026 6:53 AM, Andrew Jeffery wrote:
>>> On Mon, 2026-11-09 at 18:41 +0100, Dawid Glazik wrote:
>>>> AVCRP is an Intel x86 server platform equipped with an ASPEED
>>>> AST2600 BMC. The BMC is used for out-of-band management, platform
>>>> monitoring, and system control.
>>>
>>> It's probably my fault to some degree for not providing a better
>>> explanation of what I was after on v4, and for merging changes from
>>> others in the past that were pretty lax on the description, but what I
>>> was hoping for was something more like e.g:
>>>
>>> - f28674fab34f ("ARM: dts: aspeed: Add NVIDIA MSX4 HPM"), or
>>> - bc83b7353d2b ("ARM: dts: aspeed: Add Facebook Anacapa platform")
>>>
>>> Are there more details you can provide? If there are, I'm fine if you
>>> reply here with them, and if there are no further concerns I can update
>>> the commit message while applying the patches.
>>>
>>> This also applies to the JNCRP patch that follows.
>>>
>>> Andrew
>>
>> Hi Andrew,
>>
>> Thanks, that helps. I also found one more issue in v5 (uart-routing
>> issue), so I'll send a v6 with the fuller descriptions below
>> instead of having you edit them. Please hold off applying v5.
>>
>> AVCRP is an Intel x86 server platform. The BMC is an ASPEED
>> AST2600-based RunBMC module on the platform's DC-SCM. It supports the
>> platform's out-of-band management and exposes board management I/O such
>> as the system UARTs, status LEDs and control buttons, while integrating
>> with the host's telemetry and management infrastructure.
> 
> Can you talk more about the division of duties around RunBMC vs DC-SCM?
> Can you describe how components of each spec are used in the design?
> 
> What's the motivation for designing this module vs using another? Are
> there any specific target platforms intended for it? If there are, then
> some further details about those would be nice. If not, no problem.

AVCRP is an Intel x86 server platform based on Granite Rapids
processors. Its BMC is an AST2600-based RunBMC module on the
platform's DC-SCM. The DC-SCM provides the board management features,
such as USB, system UART over USB, status LEDs and the power and ID
buttons. RunBMC was chosen to enable a broader BMC ecosystem and
implementation flexibility.

The BMC provides the platform's out-of-band management. It exposes the
system UARTs, USB, network, KCS, MCTP over I3C and LPC POST code
snooping, and it handles the status and ID LEDs, the power and reset
controls and the host fault signals.

> 
>>
>> JNCRP is an Intel x86 server platform managed by an ASPEED AST2600 BMC.
>> The BMC is the platform management controller for the host system and
>> supports platform power and reset control, while participating in
>> out-of-band monitoring and reporting for host faults during bring-up and
>> normal operation.
> 
> You don't mention RunBMC/DC-SCM here, so I assume the BMC is integrated
> into the platform? Can you describe the purpose of the platform itself
> (beyond the purpose of the BMC, which tends to be the same for most
> platforms)?

No, JNCRP also uses a DC-SCM.

JNCRP is an Intel x86 server platform with Intel Xeon host processors.
Its BMC is an AST2600-based platform management controller on the
platform's DC-SCM, providing out-of-band management of the host
through KCS, network and MCTP over I3C.

The BMC controls platform power and reset, and monitors CPU and memory
thermal and fault signals as well as host processor module (HPM)
presence, FRU and fault signals. It also captures POST codes.

I'll fold these into the commit messages in v6, together with the
uart-routing fix, so there's no need to edit them when applying.

Regards,
Dawid

