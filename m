Return-Path: <linux-aspeed+bounces-2303-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E71CAC5A7
	for <linux-aspeed@archiver.kernel.org>; Sun, 21 Sep 2025 20:24:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVHlZ0rnCz300F;
	Mon, 22 Sep 2025 06:24:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758486266;
	cv=none; b=SZcuat0Oml9k5WbbvqyTNou58nJtS7ulVQNavhC7ZFLcw++yWN1jdfS/J8QPGjl2fysJ5wdgPPwBiWDm7HK1XlQ/eLlmkVe/KI7IDG4QPjqoFEBoir5b5YO6ehJTLzFrb+t+vhqlXK8m3cQfYhRlP2+rEO3EmZZtqLemZTu2WKb8AH9XYMYeVMyG+YOqQ0zeEP1GOjyloDLP23WIJ/fbvN7efe1YASyV/Opj6s891PJhPGWuioBASieX4WcCzRx60y/u7WbYUQaXJE7TLBlTtV125BG4ifpjirnE4dA4uNmIXrkdfpgaVoPWN17cZjlWimgK1ZleweJGISBOwkYsZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758486266; c=relaxed/relaxed;
	bh=cl4D9hUZUtyBRnsjCdqkFO48i3UvAPyAgu61Fe1pMqA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Date:Message-ID; b=DUtvoEFaJZ/q9cNA1h4I63vToZ2mnwoxUjqAqbWxZhsBZoASRmzd9xDHvS7cAwSbX60B1Q2tqmiMIFCatSiQXAdnUtyiAU+oEdpcMTNR3hDtgjAtSb6eYTETSM1CBasjzDiv+WkwiYRjvu/MUgyWGcsyhyQoM60LL5ErYa6xy+dfuTePRbyR8cjLTMjxhYRA3j/A0YIJ9uGpiIcVELJ5KNzFHAcqvQE6HitCuYKEqw1JGe6nwcLgG4k/M9eHT5XpUfzsQeS4r3yUOltSfyfllPkIVBwV9Qi2PeFk6N1toRdMjIOnWBCMZNXwf3yQ3/WrjGReyF33FSN9T0ndcZSlAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CCqlKDEA; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CCqlKDEA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVHlY4L8Vz2ywC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 06:24:25 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1752F40A89;
	Sun, 21 Sep 2025 20:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD09AC4CEE7;
	Sun, 21 Sep 2025 20:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758486264;
	bh=cl4D9hUZUtyBRnsjCdqkFO48i3UvAPyAgu61Fe1pMqA=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=CCqlKDEA4r7GqOWG5skVOB2Iu9N+uR094A7LnesewCQ9G6PLo3r6MZNzIkizZzUbv
	 vx/qQqgMVH9qdLM+tYZ54/PM+hv3QS6ayJeF+fzfv7D8s+9AAUj/LeRL+dP14YmdDe
	 kKgLk2m/q7qwHEf/ddIIWuYwHNXNA+T1RWC1Ugg9hP3KLQVX8sAoRfSBPeGWMeXqQV
	 G3dbddeLo5KKPyNcC8XggcfzghwNN88vuiPfQPAbYl6+RsKpkbrGHv7S7sOgEb4GUP
	 iZBToyo1Byafali3QESd/Lq7M2jZV1GjuioJ3ZOjXMxbJIXhYNQ4kY1/MGc93tI6aW
	 yth9FRqyKQ7dA==
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250917020539.3690324-3-ryan_chen@aspeedtech.com>
References: <20250917020539.3690324-1-ryan_chen@aspeedtech.com> <20250917020539.3690324-3-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v14 2/3] reset: aspeed: register AST2700 reset auxiliary bus device
From: Stephen Boyd <sboyd@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Mo Elbadry <elbadrym@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, Rom Lemarchand <romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>, devicetree@vger.kernel.org, dkodihalli@nvidia.com, leohu@nvidia.com, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, ryan_chen <ryan_chen@aspeedtech.com>, spuranik@nvidia.com, wthai@nvidia.com
Date: Sun, 21 Sep 2025 13:24:22 -0700
Message-ID: <175848626231.4354.7465068928065485494@lazor>
User-Agent: alot/0.11

Quoting Ryan Chen (2025-09-16 19:05:38)
> The AST2700 reset driver is registered as an auxiliary device
> due to reset and clock controller share the same register region.
>=20
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Applied to clk-next

