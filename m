Return-Path: <linux-aspeed+bounces-4699-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD79C5B572
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Aug 2026 15:12:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLTPR4Nbzz2yfN;
	Fri, 14 Aug 2026 01:12:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786633963;
	cv=none; b=HRToLk+PezpsAux2lhqHahUoQA+pQCS2koXGWfcpaDBFZWps5hB3qbTw8CU63emPMZsZ1j08Z15Pn/rAz+707tUIWu5rVbStznzVz5+LQcldxj2HuJVpiL+L8TddzLFfiPMqbT8LeSo7wGdZ31PiW3HLeKqpCfp6n9E03mWg9k3T9vu1n42f1XLlJbDF5IftDG9b28a+htGJPTYxHy413Ac6a+twBFPHk1ft5qjnfU2I2laPWXueX5Ks/o1vhThIrLItKiKpQiQlAmJv7hUMH7ajdDnEeddqC3ZY7SBXSBYLGGneoxVFA3/G48xE6tCnQad0D0YGMgDqzkMdNTqs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786633963; c=relaxed/relaxed;
	bh=d1VN5J3PqyqZfjhRbif8FIhRVduCGFV2/xR1rtZPKpg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=IH6+TlGYeNC+oiVeUvYPArtkRazOBQYi5ISr2jxSGgecZinMvFfSFpTvlEu8hYPzDhx83xscEX+xL/R6ctewlwL0rnf+eTfg+M9M8nuvD4FQ0W6E2FSI2NpMZLlDPMtK9S5tYGE213mTtnn9Z00P5L4ICWXYiV0L6fJjC14MSA0wUlWZPxgZdbakpA6WC+fBdV5JnLh+i2HV6Zd4tJkHTCpicdGMgHJ125M6WR2RDiLLdo57/GGcCUCIfJVdt03WG3Si1HJ6R3npq4HeRMlmjGQegdc+Bju67ww4V2/c8BPzbdoYKIQ4xvRPVDBls/4md55g2a88omSBx45k812N8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Jx1u/duC; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Jx1u/duC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLTPQ2SfFz2y1Y
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Aug 2026 01:12:41 +1000 (AEST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so244475e9.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786633958; x=1787238758; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d1VN5J3PqyqZfjhRbif8FIhRVduCGFV2/xR1rtZPKpg=;
        b=Jx1u/duCd33UY0ZaK/Ss1NoommksbQBjKP3i5BfQmtjx5QBgPZ1tcgHGgiSHFdTyfd
         +FJBSUmRIOd5+o2MSSO30iVvARjDhKl1SxD8Z97moqBdAeYl6xvkKPuDfLFJxFreIPIw
         MV+EklD0GhKSjHjcylJsMdbfWHPo0H1tyJB59GsiZh9dHaAIMt9G5iCQNfVSvind0t88
         35zBj9bV7VtfSDCHP8YTkoxp6lDhKhHib7OdGNCewUEx/4DfabDJilRQ79sFR1Qbrglp
         4DpFCD3zdSJx/nYLdqtwnrImvSm4QIkby40UOmda0xAvk+s753hmUZLW0CaUn4r/IzOP
         SFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786633958; x=1787238758;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1VN5J3PqyqZfjhRbif8FIhRVduCGFV2/xR1rtZPKpg=;
        b=o4N583Tc8dtANDPLyuC+1UfFoDnJsaio+zaNinCVhTq16qSyonbX29pdTOHgr4Rxnh
         wsxnpNQLflF/V2Own0sC18DBPkWxjeEkj6U3xj1g/J4foOvVItb72ySmyze4Bebvch7j
         ccmaPpZif5NW8thF35nRdwR2ALBZ4NSv06KzmYdaL6f6aeSygRDddhN0Bn4rIiWAg54B
         C8FO1sKFXj6vX3wYBC2EStsd31TL7Qau8VSR2fFHPEu+WhdO+4dAoYEwwkfwK9ABv1Cx
         wHbHPvRRJ8uzOn3Lp9zBhohQW7czepPu7XEoVqqLS3EPkYKEr7Ysh1vm9fJ1m1jDX9SK
         5G0w==
X-Forwarded-Encrypted: i=1; AHgh+RqT+aR6Uz8vpHAiiiATcoXmWVDqNY1yC/n65tQj2P3jMw6DeTuAMyyMorMhnW3xSXOf4XfRh7AmDk4IP48=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzLvFVQdhz+T9M5SgaHxpvDjdW2yX6ZCkOnqzk8ciaAtYC5pZIz
	7d7N0XsOpOwlT7N9J5MOwyo3MK75f+gJMgAztvZDlZrBF3m6k/c31okSYOthNIqK1jM=
X-Gm-Gg: AR+sD10HAhnzbN7YEKKKbQGbTuxCgmItAy0Vwe8JxRC3ZmlZSppXH3KL4iON98NyMJR
	mP3y2rXdL3xJruuINzAEjN+WClK9LscsCJll4o1jaW9rP6JVqkhH5L1rsD6KCosP7IYTsF/zMOn
	1qLZs4JKtFRMKMRdj+IfnCyPU/LqLv7A/A06c6bjcYXI+rtl6zbdGY4kdG1tdZPxstknUVKQdVo
	l36eL0d5X2UwM7sAfPZxTg5B+KpaiplXilDUrN3qCoKYBJ3OUucTUAjOE+Pt0o3BPhlqbRLqWvu
	bO66z1PTsgbznN2cShR7gJYzGbspb9FJsLIqFqOldtUCEm4NnRMZl++/8w4YUXv0iXHwiby5VH+
	2euOVSdLk0+c2jFfYdXVXo3KwrLAGBGgdfUsb2RevP9b0MDQl2mnFyg8XH74MQbUZDzuQYBYmva
	sl/hjvsxid3tu0aWoX4AuKT6iocWvrk2LtszEEKUCH1LC8ps+9lBCIScpnx7Ozs/cowDXvVGRSj
	c5guA==
X-Received: by 2002:a05:600c:c054:b0:499:7aa7:eaa7 with SMTP id 5b1f17b1804b1-499821fa293mr61233085e9.15.1786633957761;
        Thu, 13 Aug 2026 08:12:37 -0700 (PDT)
Received: from white-mocha.local ([2a01:599:447:e518:cc7c:e59e:1489:db94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49982121649sm66878705e9.1.2026.08.13.08.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:12:37 -0700 (PDT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 00/15] ARM: dts: aspeed: anacapa: restructure
 devicetree for development-phase
From: Tan Siewert <tan.siewert@9elements.com>
To: Colin Huang <u8813345@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Conor Dooley <conor.dooley@microchip.com>, 
 Carl Lee <carl.lee@amd.com>, Rex Fu <rex.fu.amd@gmail.com>, 
 Andy Chung <Andy.Chung@amd.com>, Peter Shen <peter.shen@amd.com>, 
 Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
Date: Thu, 13 Aug 2026 17:12:23 +0200
Message-Id: <178663394346.25776.3034382955561000147.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786633956; l=966;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=5nv+Mr9p5XaUi062nk/bzZw3jZRcU/o4Y1TWhXSnZQQ=;
 b=ixzRg0WlxQZmgEqHtR0ys1/8RqBVI0WxN6HGIy9/D2QEYFaW0DgxzfXMucvcSaQRuLtVu2tFD
 m+urC0SrqcpAbEpCpR5K/W3yetTllGyFJL3w5MUH2QxUVs6XbsOQVnp
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

On 13/08/2026 13:59, Colin Huang wrote:
> This series refactors the Anacapa BMC devicetree layout to better support
> development-phase hardware revisions (EVT1/EVT2/DVT) while keeping a platform
> entrypoint.
> 
> Signed-off-by: Colin Huang <u8813345@gmail.com>
> ---
> Changes in v5:
> - Remove redundant vhub pinctrl-names
> - Use default SPI2 memory mapping
> - Fix dt-check-style strict violations
> - Add Acked-by from Conor Dooley
> - Sort compatible strings in alphabetical order
> - More commit message for ARM: dts: aspeed: anacapa: Add EVT1 devicetree and point wrapper to it.
> - Update commit message to describe both LPDB and RPDB GPIO expanders
> - Link to v4: https://lore.kernel.org/r/20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com

Errors that were introduced in previous commits of the same series should be
fixed up instead of adding more patches...

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

