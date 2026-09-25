Return-Path: <linux-aspeed+bounces-5050-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC307C9830D
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Sep 2026 05:45:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrfn61sDWz2y2M;
	Fri, 25 Sep 2026 15:45:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790315130;
	cv=none; b=DPR2WZWqh5w6KnFotpwWenlSTb9Ybre440XE5uQEUhAJpxOK9hA+J8Rneif5+kmh3rXhwIfv811TCEMFaJB/ztvEdQImO1OgmHe0kwsw5sDlUj/qCMS9T0DkYAzgmRvEqy2NbL3yzEOaVoFuWts9Hn6gGGE/Gpw6DlFVx9Rokc/MKx6FiULzZA4WE41mcn/mF7xaZ3K4OYlKuIARp2CxrsRnA8QJf3zFge+jWX8kl0rULwDFhQD/X1q5IA8rUkzVctih7gd0Nps4OXF/Isqlfrzrp5u7w3mI5Grd8IyADDQzuQqcgJKcs4sHj6WtFT9+sUc1LsgQnfQXV6qBoxOPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790315130; c=relaxed/relaxed;
	bh=PlzdRlGdd7Zikk7dSYBL9Z3ARN+aV/+uUufDBsrWN0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huoo4KHhJDR4VuINGlB7LNNR2H23Fq7jKxOh/qECt4M0kP79CI7QTmWvIhTCWo+Xm1Cg2cclX3c9VXg1qaGYDNwFuBXlIL9c/h/+R/KhbQPu3rjUqaoqZEYzzQOc3K9qyWr1bK2eIaJiyKfsq8fL3Ma1HYVb7SduO3GZUiPw0b2wSNC5P9+hw2nD1cGNQfmZ26iUmHP9+JpnpIRuzKV4foqOG1ROJjJVzy5D7E1jAWzGPy9OT18dc/xlrwhtQTe0Mt/qNUM6QbKpsFzF1rZBMhxRWwODu3Wj5P+xtchGXtCr3DRxSQSbT/Xs4t4oGPxxb5RLvP27kJ/siMJxUDDOFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=j6dCNb4q; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=j6dCNb4q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrfn26hwGz2y2J
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Sep 2026 15:45:26 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A242840E00B9;
	Fri, 25 Sep 2026 05:45:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9KrOa-5jTJs4; Fri, 25 Sep 2026 05:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790315104; bh=PlzdRlGdd7Zikk7dSYBL9Z3ARN+aV/+uUufDBsrWN0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j6dCNb4q4DEnZGpA1r035JAlpBfaLS4NWe2t1SfkXoVCcu7MAxc7Zz/gdAY56/zxz
	 pPGsuPYGYL64QW5BRKaU+3DpTJV+Iu8+Z/r3+tZI2r3RMWbQkzUmRbxRuCOcCYSk67
	 bWQCkkqNI2AQtI7DJfyGUy0MxNUZh6ipm/wAPSJ4ZUGUC/dtlzAp5Ai5O6JiY5d9H3
	 YUBKDeScKnqPdLqcJMR5L9X4iqllWlucqJwRVnCQVjN7u5tcEE1AiJfkfT5Y3R3+ZQ
	 GFRPRLCGB1BCWGETcarq3FHPlYdVdoabup6JGIERiK8LMsLJSliIUvPAQjps8SfAso
	 wQXUjfhuqfSGwlnnmbHGn7iGuZvhU3lD6NI50VGDgSMCqrRomG7l5/Nm0ZXLYGEDDh
	 H1TiQIHRx/7lDWkF3DlRS+WIbBZ7jX4Y6XQPyh0BrsSRnaLPZZ7LoRCkuFctIEIIu3
	 IoTb6pk2dRglmtBBM61RPgLO8F+pIGjQkrjTAhRqT9S77hXe1JoF5UH8L4hHRckVU5
	 kXORcBF8gmIVw/qnMMf9RqJQo8e+wZajdTFtAYGKc8aB5Rk7Y987RCOTMcqZ3Q+r36
	 A0qQ5U7ycmceX9Vf7sDlQMl7u5QqPG4pa7JNh0BpgHstaP/NaojAzSwljg2BR+8wrI
	 OQlkA1D+pLmyus4rriXx1Skw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F168340E015D;
	Fri, 25 Sep 2026 05:44:47 +0000 (UTC)
Date: Thu, 24 Sep 2026 22:44:44 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Add Aspeed AST2700 SDRAM EDAC support
Message-ID: <20260925054444.GCarYKTAdrrJ5a2VYO@fat_crate.local>
References: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-edac-v3-0-23e9ed2fbdf9@aspeedtech.com>

On Wed, Sep 16, 2026 at 01:30:37PM +0800, Ryan Chen wrote:
> Add ECC error reporting for the Aspeed AST2700 SoC to the existing
> aspeed_edac driver.
> 
> The AST2700 memory controller keeps the same overall EDAC programming
> model as the earlier Aspeed BMC SoCs, but uses a different register
> layout, a split interrupt status/clear/mask scheme and DDR4/DDR5 memory.
> Rather than fork the driver, the existing code is first tidied and
> generalised, then the AST2700 is added as one more per-SoC variant.
> 
> Patches 2-5 are bug fixes and cleanups to the existing driver. 

You always put the bug fixes first in a set. So it should be 1-4 bugfixes,
rest new features.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

