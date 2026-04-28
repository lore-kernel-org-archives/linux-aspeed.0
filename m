Return-Path: <linux-aspeed+bounces-3963-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C12FF8864
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Apr 2026 01:41:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4NSh0tWBz2yjp;
	Tue, 28 Apr 2026 11:41:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777340484;
	cv=none; b=NyM6EMMc5JGx9PKGJFciqxj96O/lVMAXKO7Wi3mDqY2En0iIibZAIvn04okVPp+5i3QIIY8SUvFRiJCtFXrfy+E234REdbvilveNc+nVckvCLE0l7ZF0T4HqJvycEQKkBlW4Y6Z9OVSfGMAWgkAO2wdlfH3IuQbHeIKG/iz4FxXDUSf5cPyYWWyivwPv2GiYxHf135EwhVK75Z4LK6mwSBNAgKLzPzx+4moY7XWAekFM+K8nUi5gJT8/iIPQbr9D8Kmp7X9iWKL7iXQ/w53m9wpltxBntXWSmnaxzq5aHxvGIfaxXPgY0AMzLZPtdTbAYXwVQqBh5eH6pPRgDWs7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777340484; c=relaxed/relaxed;
	bh=kS6Nhw5Xce8gKlfbWDr+Qz8JGBd5F/n/TDPtz8b6uAA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Neg31EFjZjdo/IREfV9STNuBCrOF5olyGwo6Y1uBqkDcJTSnCafnTYE5H7y49jYBZj6WLIWTcn5Fuli/kh5JWAmiuGzeNh8DWZNahVirlvpsOfoHuC9B3Zq3I53BioC83vsag4A6H4JAHjySRx2ngnTfbCIkB0ygO8cbT8flZT/T5Eil4M/BKawF4xGgd2ZxldwgNUydPUsdCpAHAEkz8SuAv+TuFg35gB60xeRyZ7WkjLSgCwrQiuq8wVz/DNStNG7Vxfe01UJEZTFVZgRIXiT1+Z+HwrubltUVFzVu1bbIjyjKjorN8HwPR9EBw8YXF1CwbrCljwHycheC+ikOUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LDcHkvqR; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LDcHkvqR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4NSg0srlz2yYs
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 11:41:22 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 94F9B60139;
	Tue, 28 Apr 2026 01:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA22C2BCB4;
	Tue, 28 Apr 2026 01:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777340479;
	bh=kS6Nhw5Xce8gKlfbWDr+Qz8JGBd5F/n/TDPtz8b6uAA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=LDcHkvqREYp21fdsIvE3hqicidetzAVcadb9CaB0WYDnqYnrA8lTHHvloce1SbuxG
	 YqR/+K7fb9XNMtUTnlH02uCZH3MwxWVw/RAzzlvPIcEtSrpDEUHCYpcbf4HJb0OCgZ
	 z//4Izk2qtg2e1vAzVsbrkSC7CEGIrsoA95wzvz1+KAUUQGtxMOrqe+Qa/TFTH5E1d
	 3ZY12EXWUND7WfnXAfRxnCOfGQBlDKaixZx9rEJYbNJjW5kBR7yrzRAeB08UcpjJDJ
	 u+fg5FLNnDott4iqobSvT12fh+Up39IdmxWl7bqDDaGRvwSIX4QCmKAWDse9NegJCX
	 tVMD4hXdTsLjA==
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
In-Reply-To: <20260302011651.94682-1-haiyuewa@163.com>
References: <20260302011651.94682-1-haiyuewa@163.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: ast2600: Add reset definition for video
From: Stephen Boyd <sboyd@kernel.org>
Cc: Haiyue Wang <haiyuewa@163.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Haiyue Wang <haiyuewa@163.com>, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Date: Mon, 27 Apr 2026 17:31:28 -0700
Message-ID: <177733628897.5403.16418225590380642017@localhost.localdomain>
User-Agent: alot/0.12

Quoting Haiyue Wang (2026-03-01 17:15:00)
> Add ASPEED_RESET_VIDEO reset definition to the ast2600-clock binding
> header. It is required for proper reset control of the video on the
> AST2600 SoC for aspeed-video driver.
>=20
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

