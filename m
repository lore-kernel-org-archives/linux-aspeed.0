Return-Path: <linux-aspeed+bounces-769-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4315C021AA
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Feb 2025 11:32:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yxy73334yz2yyJ;
	Tue, 18 Feb 2025 22:32:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739878351;
	cv=none; b=BBEihhEQZaqKOowlH+hVsI4URcE0JOw90Ws3bsMOvMSE/WT3FtPQPdl18gCK2NAMDkh3yefnhHD74tfnKxOxqjxznNKsLsR3KKEtL2V3dLbWmTpa52vCa9B+bSUkofFwZFj8nycMJpKbU0Uf8Kj/ujAErXDib6/gRv3rUWxtUBP5zZsAmwLL6Yml/Zj1TgiBX3EHC1d5fSjVEaRZLozGYNWbGQWARxqt2/J3/PU6M0btpT1LzYySSJ+1PY6Fbvq9IICTbDX+MWYWVxMONZFARMizd2XNPncUGNHpAbeGcSyS5iICkDkCFCXB6DXfwW3LTZm1PzR81Oo68LDJEhjBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739878351; c=relaxed/relaxed;
	bh=Apmt/MHZfjM69CNGBCus+eU+JQB1nzJgmT7WzA3w2kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G0ikzNnTF78JPUJvgSkcyTWjx5ibPP0JCEltNijYYKDuF/hlA97Jaip2NvIH0W3SaSB9UqV4B1mc6hzjUnUu8/ZlD4bei4i0BXMrOm9IKZ1X1BC/V67mvbk8kxaUXktMGGFeW/BHuKipaEMhQ8mVgoX4ludau+eTjTTGIup9oPUufrQPpKFI2eowcVodWb8XjOrp8pdYMG7/h2sF4PFmIXDsLtzpUVaLj6HnBZm4qM/HxJIvjVuNR9USP5cXA1i1T0ZSIs7eD+fPWVHYNMv/RzOcT83H/o+Qbd7Dr5zROFHAq53ITdUEUAoAZbcYH8/hINQKHF/G79J6FQqvRFG98Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OLIujiFy; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OLIujiFy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yxy721zSPz2yvv
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Feb 2025 22:32:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AC189A40145;
	Tue, 18 Feb 2025 11:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B011C4CEE2;
	Tue, 18 Feb 2025 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739878346;
	bh=ISkMgIu5CG3Hb3jbYuoH8+hOc7SA7NHBdbl+lD64RIw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=OLIujiFyk8wPhQbHU6EYbxBs+ngzMkdMcdZnAGvWtIi/6F2/Q3b/pTZZsCUo7UvU5
	 PHoQ1u9YG8wleocvnY2YofHTeEC8SBICrgr7en2XLQsCvSxColjOrb919Xl38EmZj+
	 sqp4OZ78YG5tNicETUSuwOb5mU/QFAq6+RY6OkA4PQ+k4JCcxd0EcfRKQrXLYAkttN
	 xNOEtZ1f1V2pxWYLp1H1ARccXjcqsBN3fMEXz7h2HJqSOFL8oO2CaCTSBji2vDJnu4
	 wBgWnwlPqMh7yEaCg4vvZ+rQ1VyMRfefizVN9SXc9wj6ABqMiJ+TnQ2usyC4PCZX0v
	 hdYQTdHaR0WqA==
Message-ID: <a1fb9bdb-6c11-4aeb-b88e-7a65861e20d5@kernel.org>
Date: Tue, 18 Feb 2025 12:32:19 +0100
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 1/3] dt-binding: aspeed: Add LPC PCC controller
To: Kevin Chen <kevin_chen@aspeedtech.com>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "elbadrym@google.com" <elbadrym@google.com>
References: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
 <20250117095217.661070-2-kevin_chen@aspeedtech.com>
 <bad78886-2577-476f-a80f-e189a178b26e@kernel.org>
 <PSAPR06MB4949CB5CE2E08B98B368160589FF2@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <78dc2cee-2d87-42a9-8e0b-2199c653def4@kernel.org>
 <PSAPR06MB494959646EC7A8447056777B89FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <PSAPR06MB494959646EC7A8447056777B89FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2025 12:05, Kevin Chen wrote:
>> On 13/02/2025 09:46, Kevin Chen wrote:
>>>> On 17/01/2025 10:52, Kevin Chen wrote:
>>>>> Add dt-bindings for Aspeed for Aspeed LPC POST code capture controller.
>>>>>
>>>>> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
>>>>> ---
>>>>
>>>> Patchsets start from 1, not 0.
>>> Agree, I will resend the patchsets of v1.
>>>
>>>>
>>>> This wasn't tested as it has obvious errors, so no review. Test your
>>>> patches before you send them.
>>> Agree, I will run "make dtbs_check W=1" and " make dt_binding_check " to
>> check result is clean before the next commits.
>>>
>>>>
>>>>
>>>> <form letter>
>>>> Please use scripts/get_maintainers.pl to get a list of necessary
>>>> people and lists to CC. It might happen, that command when run on an
>>>> older kernel, gives you outdated entries. Therefore please be sure
>>>> you base your patches on recent Linux kernel.
>>>>
>>>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
>>>> people, so fix your workflow. Tools might also fail if you work on
>>>> some ancient tree (don't, instead use mainline) or work on fork of kernel
>> (don't, instead use mainline).
>>>> Just use b4 and everything should be fine, although remember about
>>>> `b4 prep --auto-to-cc` if you added new patches to the patchset.
>>>>
>>>> You missed at least devicetree list (maybe more), so this won't be
>>>> tested by automated tooling. Performing review on untested code might
>>>> be a waste of time.
>>>>
>>>> Please kindly resend and include all necessary To/Cc entries.
>>>> </form letter>
>>
>> How did you implement this feedback?
> 
> make dtbs_check W=1
> # Check the lpc-pcc or pcc message from the log
> 
> make dt_binding_check 
> # No Error
> 
> make coccicheck MODE=report
> # Stop at the following log but no related log.
> #   OCaml scripting is unsupported.
> #   coccicheck failed

You answered probably to earlier part of email, not to the one I asked
about.

Best regards,
Krzysztof

