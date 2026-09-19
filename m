Return-Path: <linux-aspeed+bounces-5027-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2303FC982D8
	for <linux-aspeed@archiver.kernel.org>; Sat, 19 Sep 2026 06:44:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hn0Mj2jZDz30Ng;
	Sat, 19 Sep 2026 16:44:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789800257;
	cv=none; b=LROq8fuKRKGf8ZLWzkX3GV7lM/EgXIOXCcfUY75ecL1Lus+KLlhlJhnN4Nkz6stmBTJ3yDcKFwaWEZHvPjPeQdBxc5BVXKHObRdKxcApdZLDHnECEQ7URbqgooJ+K1RHXKL1uGSwypBuby8lIaVLyTSPeid9+eeSuDR0UUF09TrWdx3A+ZnJldDBahgzKmMXBLYkQuyELDjk4Am5KNCqTmRVsZ1z4O2nZmWFUd2ap5CiDXajnTq3XaQPPLwOLLq0HUDGF0QS5TGz79zDY7ZMHtCcWu0xOqfdNpYcfRUVZMWJXUBC3Z0WDXdKO5LG4tux2bOwkvjXc3eJx12vy05ODw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789800257; c=relaxed/relaxed;
	bh=+NF44E/ilbxIzqmKrtLGcEZ0p7032A0tuueyzi7LgW4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lUxgc9U+Ax0is+yBUHUIJ2vSMxxmFo2Ow5/s1ic+kyJqOaFI688POz6JKrffvr0XrQdWDMq17LllfInipqP+UgXvGAHjTyCtNgmwqq/0nHTTByJTVzz8GhsnIwn4cHb4gLLYnbeBU+YUsfgHoUMnJyLIS06PmFudboxNdNZ6E+jO80PvOsSeUqoGdqIN1tW0Rq5MVLsYguEF4QEiQ4vdwghkQEljkaNdcxbCVB8FIzk4YYl1Akz0TDistMlhHnREJ3l/kYc1GFpSvyvj0tnmg3cu4orQkMfSwyTAdaGp01atKiv6csdXmxKC80escm2vNXwW7xMmS/VsvGbeuu83IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2OWPAm4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2OWPAm4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hn0Mh1Vwmz30Lw
	for <linux-aspeed@lists.ozlabs.org>; Sat, 19 Sep 2026 16:44:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 57EDA602C4;
	Sat, 19 Sep 2026 06:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587851F000FF;
	Sat, 19 Sep 2026 06:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789800253;
	bh=+NF44E/ilbxIzqmKrtLGcEZ0p7032A0tuueyzi7LgW4=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=F2OWPAm4S19tf979eebZVGTq7EE+qd4tehDuhg5UhhViEufXnaNjnAsfiNNtqRNcz
	 YpUD2TiYqB5JwSlBAYlUT1LAZ8Ojh2PFy1D/nocPvj9MpgrKgwGS2JEYkxM/XZh47j
	 N+hf/OSKiAkFahlpfQY+rv7si2ljQKlrv15eXz8LKk1DsJQ6NuuaqHbh3sV/MOVU6J
	 Hq4BcFQt/bDb5aflAdXlNRHjS4vAPtZoPIBsFotnkqSvSqwmlsIOqME6UV8f/akoO1
	 5wGWYbshDDB1c9HmF3vHh3rYoiw7oQKYcpCyIkHSbqupgrm8V+aVkx8hpr+c7997XM
	 ppX5If+CJGisA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260829194054.107929-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260829194054.107929-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Replace spaces indentation with tabs
Message-Id: <178980024987.89886.1304993290857665882.b4-ty@b4>
Date: Sat, 19 Sep 2026 08:44:09 +0200
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
X-Mailer: b4 0.16.0


On Sat, 29 Aug 2026 21:40:55 +0200, Krzysztof Kozlowski wrote:
> Replace excessive spaces for aligning indentation into tabs.  This will
> be reported by dt-style-check ("[mixed-indent-chars] too many space
> characters in indent (more than 7)").

Applied, thanks!

[1/1] ARM: dts: aspeed: Replace spaces indentation with tabs
      https://git.kernel.org/krzk/linux-dt/c/5b21342479d303b98796ee50a50642843318e92f

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


