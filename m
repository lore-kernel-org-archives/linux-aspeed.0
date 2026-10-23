Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99799606A32D
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Oct 2026 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ko8pYAVg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9yF564RKz2ySl;
	Fri, 23 Oct 2026 20:21:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792747273;
	cv=none; b=C48Gl8CinjwJdsKjUVWZiuifNuHrox5wky9IS7pkfh8xF+5g2MZGUdCvkYa+BIvjNjCyrTLgQ+6LlIiFphrqq4UyeE2kM/rJQ8/vh0ZTHkPcOJfqXo8YBZYWaxcvLeUf4MnoLi9vA+32x//kKYmwpKRxtiQs+x/dXcaaoMXegrx2BX6mzdYr8xaXUKFGBWvLFe8ybxSnLXxyiVduZf6VCv3CqKpacJxXhq/TNWLSYTP4E4Jz6n8UHBBdft96Y6hQeCs4roxZbsfztR55jbOXkwEDRtOCTRfPDDiyC9GrOizTM/B5HwahpcW7/vvAQftV+/gMNOxVP1HT9fEYITb10g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792747273; c=relaxed/relaxed;
	bh=LtgqnPwkSNepb5rhVYGZGg+M7ky5lb2Mgj+7aMYIu38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCOturcvQiJ888/Z+U9+mOmnLOtITg7Soipajur2OyiGNjwjVZ1ewLXhLEEWC8rn1rsRXSOU2txyG7/vMdYn4q4a4RmKleu+k1hXIOkLC8SChNbSgF01HfP1GtZTVmN29aFIu1J0a24pQ/+8Cl5+dn8T+6HdGNyZpdTTi+/MqhiGETfbRczTQS0Io2sR5F8THsxVM/3hbzz/AWNZdUXl72OCR1SyeqiXtbvrkrYn6/e+fpGW+EULR6RDK8yWxv45pCeaZ5TOGpgYLDMKEC/+TefT8OcTvNGVVDjcs/0f/hh6llJmBlbtf3AHCyIdEyy77rpHQoJ4qqaCpl5voIMR7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ko8pYAVg; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ko8pYAVg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=dawid.glazik@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9yF30S3pz2ySc
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Oct 2026 20:21:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792747272; x=1824283272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HvQu/rXlxvjhOw72+0RA9ZUcddXB/44XYkRs0LAsZco=;
  b=ko8pYAVgfLPLa1XNUXdnfGVDyohIjTtPGgYvCnwsABIli/4SMvjqWwIo
   AWjikQwUgtj8cIw8wB+a/KEZ/yCC2QifdZujOP5aQhTGsk2UN7KpGG/Mc
   3L5e0tDoE3jXAm5LnmQncUY2wLd6RX5EVU71oTm54li1aMu+tmXw9LkbS
   U+i+XciyZYlKOrMR5vJ1O28JvFu4cpfgi7SYqSv0lP1dz/lwSCvKahQbv
   /l/jHQEyOug2imRxQalxDm2oFYbiKY8Ky4A7GRkG9zLYQEnaM7No2DnGi
   wjdpBIJ8POpf+3tM0yvQ+a/aqBbJ2BpOe4wufSDbSxtA80DXBgxyd6CDQ
   Q==;
X-CSE-ConnectionGUID: ZIc1FMQ2RGKUUGip7pGIzQ==
X-CSE-MsgGUID: Lzec8NeQRQaUY2FbG/nLUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1400726"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1400726"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:21:07 -0700
X-CSE-ConnectionGUID: JilZZk58SwmSD3MCGwSnXQ==
X-CSE-MsgGUID: PLKmsBB+RuW6zcBP54Mbsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3707489"
Received: from unknown (HELO [10.102.88.154]) ([10.102.88.154])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:21:05 -0700
Message-ID: <9561c180-ff8d-489d-9ad1-8d9a7afb592c@linux.intel.com>
Date: Fri, 23 Oct 2026 11:20:45 +0200
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
Subject: Re: [PATCH v3 0/3] arm: dts: aspeed: add Intel AVCRP and JNCRP BMC
 platforms
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maciej.lawniczak@intel.com
References: <cover.1792613583.git.dawid.glazik@linux.intel.com>
 <fb048449033e125df93c2925d6dccafbd4114685.camel@codeconstruct.com.au>
Content-Language: en-US
From: Dawid Glazik <dawid.glazik@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <fb048449033e125df93c2925d6dccafbd4114685.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 10/23/2026 6:17 AM, Andrew Jeffery wrote:
> Hi Dawid,
> 
> On Wed, 2026-10-21 at 22:26 +0200, Dawid Glazik wrote:
>> This series adds initial upstream support for the Intel AVCRP and JNCRP
>> BMC platforms based on the ASPEED AST2600.
>>
>> The first patch adds the board compatibles to the ASPEED binding. The
>> remaining two patches add the board DTS files and register them in the
>> ASPEED DTB build list.
>>
>> Dawid Glazik (3):
>>    dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
>>    ARM: dts: aspeed: add Intel AVCRP BMC
>>    ARM: dts: aspeed: add Intel JNCRP BMC
>>
>>   .../bindings/arm/aspeed/aspeed.yaml           |   2 +
>>   arch/arm/boot/dts/aspeed/Makefile             |   2 +
>>   .../dts/aspeed/aspeed-bmc-intel-avcrp.dts     | 322 ++++++++++++++++++
>>   .../dts/aspeed/aspeed-bmc-intel-jncrp.dts     | 276 +++++++++++++++
>>   4 files changed, 602 insertions(+)
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-avcrp.dts
>>   create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-intel-jncrp.dts
>>
>>
>> base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> 
> Can you please discuss why you based this series on v7.1-rc5? v7.3 has
> been released, v7.1-rc5 is a long time ago.
> 
> In the future please base changes for the AST2600 on the latest -rc1,
> or the aspeed/arm/dt branch of bmc/linux.git on git.kernel.org.
> 

That's my mistake. I'll rebase onto aspeed/arm/dt of bmc/linux.git and 
send v4. For future AST2600 changes I'll use that branch as the base.
>> prerequisite-patch-id: 23091b539ec7723a865d82da7703bf70c6ed0222
> 
> Can you please rebase this patch to send it to Lee on its own. The
> AST2600-based platforms currently generate a warning without it. I had
> hoped Lee would apply it in the same cycle.

Sure, I will reach out to him.

Regards,
Dawid

