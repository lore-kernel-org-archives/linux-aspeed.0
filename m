Return-Path: <linux-aspeed+bounces-4727-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB5AC5CFCF
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 14:39:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM4cn6WH1z2ykT;
	Sat, 15 Aug 2026 00:39:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786718377;
	cv=none; b=GqW8Dkvnm55D/aYQBEskFdvqfchC9xab9hy2mXjKcDpiaxucrcMnr6jHr9VsSV5+tI/PuFsDPJpHXGAhjwfl0d5gXEGy1O+S1pia/YjxN2a8Jk9r6JPPUJSW6xVKa0fvJu369NFrRsOHmOAY1tITA/XQHZZpQjWV8iN87wZwPKWPsIHZkEc89T4ICyiIz/DJ9ozo12t3ERFEh+jpCicoeBxznz9wy4O7tZH6JisEQE0Ii2tXzuBhiWySsDJxuR1icxzqCa1QtSzYeM40HBna/zBFVK8CIyKo+xkcDnXP/4FwFNXvWhVBWo5akJJl8PWdqxvw6ElBVo3zSHu+reFPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786718377; c=relaxed/relaxed;
	bh=VWSFL1IqtGsSxd9as+S5YrQgQ2uQorKxfncBRjktmv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnZ7Aa3SsdUccZzzHss2DLjLbJwwih9dvBbuj0xzL4+2XoQKyDwNpyGcCgFR45WDUGzF6KOg9dAo4ziKnXjWTp7k8wBHdIOXha6wI00WJxDKPt4RrEJVR6hOs1wBDVL1eQdQK0NyMana3ZI4I+U/BXtzuyKRFhPNoPF6SATXKcfQAqoIRoGJ9kzpIrJx8uYMBpjG7PdLF5A6YyYTpBXBmRMG8wWelE2PzmHGKNEU4msnYKiGNRhBELjP9y2MlvCmQEyl9laBB08lcnfPHEGJ5uUSPLupISdANF3OP9uYJpL3386+ByAcpB+ZOX9QVjwdgDFyC6GfRDx3TN5MLF9sQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=J48lugav; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=J48lugav;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM4cl72S9z2yRP
	for <linux-aspeed@lists.ozlabs.org>; Sat, 15 Aug 2026 00:39:34 +1000 (AEST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-49954b88fffso13645445e9.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Aug 2026 07:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786718370; x=1787323170; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWSFL1IqtGsSxd9as+S5YrQgQ2uQorKxfncBRjktmv8=;
        b=J48lugavALTbBdtAFWUtLPTvTj1yEklYuFswqpzOPlRYiyUqMB02+WE1qH4/gvEZO2
         7uELcidqVscij+Jqyqon0VoztUH1IwwWMFOL2ybliqpzr2NKt9Wbur3xQWScEx+GHaw2
         jcaQgZ/u5Dk+jbNWoWs8TkIld9Ub2TAIdC8ImeX9bZNOJPT3RBlewujsewv49nEIwvDk
         bFPhtsmaOucxLcYWk6kiLohGWx+Qo12R1hLwex3fhT9A86rpuGWb/LvvlxJxn6zitDOz
         y/gM897BKNvrxhdYPzbNaLLggEjmd8sP5xwPNHG8F92z+3AF5AxK3Y/cXghMlPymGEnS
         9fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718370; x=1787323170;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VWSFL1IqtGsSxd9as+S5YrQgQ2uQorKxfncBRjktmv8=;
        b=VkRUOlZkj893qYwy4jRNxvyyoK8zEE3RHCtQvuCWngdSkgHBTznE+x49ivbvAE9NSv
         f6GD7Q0kUj1m5TgtQK9uRrIdQ0GhpX5UoAIU1zhKlfZ9fa9IiBhfCCdC+yCVIBYePQaO
         HLuA+XBPVSCtDwouZlfFGsWP5uEpFyli0EXQbtP7EU7xP7yxWr5GEWX0ofN4+AjFl4/5
         RNH+Wg0H8PVsHwMj5Oy8J7z4n4UtkiFXAA1DXTlDuyzr+FSjRFTC02lg4X6aRhvl3Udz
         Ry+7kuNxCH0ZKVavhzXuOOWbx/88rDnrDVERqFS5gDjvL72gAsmj2/SwKv56DeaRg+/+
         HzqA==
X-Forwarded-Encrypted: i=1; AHgh+RrCNBWpfbulL5i/L9jeVnYihbQJbkHg8I/75rJhtaa3g+DtVFwcY/TnXdO1uY/ulBfn0HsHCWJyvDnq7dQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyBE3nTUPccdjJnNVyFLRyKbcyM/ySXQ92yDjknMeobaoKkMCTa
	SjH6cBTXA+o80D9fqLXaBgJblp0Cb6pDWV3zHm6E+7Zw31soR0ytVC8INiNbkHFZo6Y=
X-Gm-Gg: AR+sD10cgFjESI3ed2HOiiemAIy8814mtlD5MO499h4gJF2QRoP+asHPndJTvzWUBqZ
	QyEzNJPljw21BNdUdkbZmxyvgfcLsdyc/0TgwSihmXi/oCwyN+LPCcSTtOICtB1sq5thc+ZyXqO
	JrjmBLgb4TVFjgVlZHk5k/N2FjcV1xj1DwzImhho/gggTpXut/RoInwYt5fWtDy9z/RsKK8jEy5
	q/KvyHMviVva6WHs5XfVnpeP+Hq70urbozdftCzXX6lyKU/WMrbudVwAC7DVnmrl8mEl/rrmEdX
	Dtj0IXk5jtY2V4DNFykvn4cGJMGS2LdNgN9duH70mI/iY3/gIXtft1CgBQ657VjL51A9GrxSgXw
	/EUPsJF+NtT7oLMhsWStgNo9G4PqT6gS2PwH3kL8D5kRTmNRdgRX8bO5LqGs2cCuumkivfpNY+7
	YY/Djk7xez6XQ67aja0y+cBsdWKzJfzIAimpSuwEtUwNEtJDzV7bXYpmy+RFpCu1LS4j/Acgc+y
	5WYWrSJKyQ5Xa6c34wpavBNVuVjbBeaQA+A68eFcBLTji/+gOolQKEvK/kC/4Jv7DqZiWWbZ/pd
	LdIxcjkM8cXzpaoRHxO4c1UGBhbf
X-Received: by 2002:a05:600c:5397:b0:493:bb6b:5bb5 with SMTP id 5b1f17b1804b1-499879857d0mr93390555e9.13.1786718369651;
        Fri, 14 Aug 2026 07:39:29 -0700 (PDT)
Received: from ?IPV6:2003:e6:6714:e500:bfe4:7b00:fa11:e276? (p200300e66714e500bfe47b00fa11e276.dip0.t-ipconnect.de. [2003:e6:6714:e500:bfe4:7b00:fa11:e276])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899bff2csm31594145e9.7.2026.08.14.07.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 07:39:29 -0700 (PDT)
Message-ID: <b88b5e1c-e85f-4fa1-80ac-1ab66592a86c@9elements.com>
Date: Fri, 14 Aug 2026 16:39:28 +0200
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
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/15] ARM: dts: aspeed: anacapa: fix dt-check-style
 strict violations
To: u8813345@gmail.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 colin.huang2@amd.com
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
 <20260813-anacapa-devlop-phase-devicetree-v5-13-c7058f63dc67@gmail.com>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-13-c7058f63dc67@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/26 1:59 PM, Colin Huang via B4 Relay wrote:
> From: Colin Huang <u8813345@gmail.com>
> 
> Run scripts/dtc/dt-check-style --mode strict against the Facebook
> Anacapa board device trees and fix the reported violations:
> 
>   - aspeed-bmc-facebook-anacapa.dts: drop a duplicate trailing blank
>     line at end of file.
>   - aspeed-bmc-facebook-anacapa-dvt.dts,
>     aspeed-bmc-facebook-anacapa-evt2.dts,
>     aspeed-bmc-facebook-anacapa-evt1.dts:
>     - reorder compatible/model so compatible comes first
>     - add required blank lines before child nodes and before the
>       status property
>     - sort properties into the tool's canonical bucket order (e.g.
>       bus-frequency before gpio-line-names before ngpios before
>       status in the &sgpiom0 override, m25p,fast-read/label ordering
>       in flash@0, #gpio-cells/gpio-controller/gpio-line-names
>       ordering in gpio@24 and gpio@38)
>     - align multi-line property continuations (io-channels,
>       pinctrl-0) under the opening '<' column
>     - fix child-name-order and child-address-order violations
>       (framebuffer before video in reserved-memory, gpio@24 before
>       power-monitor@N, regulator-p3v3-bmc-aux before reserved-memory)
>     - remove redundant node labels that were never &-referenced
>       anywhere in the tree (i2c8mux0ch0, i2c8mux0ch1, i2c13mux0ch7,
>       spi_gpio); these labels only existed for node-merge overrides
>       via #include and are not needed since nodes merge by name and
>       unit address
> 
> One unused-labels warning remains in evt1.dts for the p3v3_bmc_aux
> label: it is genuinely referenced via "&p3v3_bmc_aux" in
> aspeed-bmc-facebook-anacapa-evt2.dts, which #include's evt1.dts.
> dt-check-style only tracks same-file references for non-.dtsi
> files, so this is a known false positive of the per-file checker
> given this board family's #include-based override architecture,
> and is not fixed here to avoid breaking the regulator reference.
> 
> All four files pass "dt-check-style --mode strict" except for that
> documented false positive.
> 
> Signed-off-by: Colin Huang <u8813345@gmail.com>

Hi Colin,

I might be wrong here, but the commit message feels written by an LLM.

If you have used AI assistance for your series (or only for this patch) 
then please note that, even if you have only used it for the commit 
message, you must declare it via the "Assisted-by" trailer [0][1].

Tan

[0] 
https://docs.kernel.org/process/submitting-patches.html#using-assisted-by
[1] https://docs.kernel.org/process/coding-assistants.html

