Return-Path: <linux-aspeed+bounces-1114-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3B8C35FFF
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 09:41:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJyBB3xYkz30Bd;
	Fri, 21 Mar 2025 20:41:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742550066;
	cv=none; b=D9FpMefM16wLmWvuG0G9z5J0M398Sl53M83+zZNIUTXcF6en+kib7TPEq9SMyRqAGnTu6Jwqgi9JKaTSEEycFpVlAfAmlE2qo/bCeYEN2fUUx3fimx5w8U9IV+ZjytAIyjd/BSc6YdBChVXeeDWkhpRwnmsINX4P3s3Qcs+8QXXgFy3A05HuYVI/Kbzsg7LpXW8/KRv0Ddv3pKGZ/SSTS4wGF5uAzorWRLm/AxQ3kceT684KObwUMkraOYX3eFJJKUjq2995wXti0pxd3135rcLDtk5iX3+V8H85PLr3u3Kgt6WpwM0zxMereEUvpCtF0jCtIFnofqBzff3dofrVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742550066; c=relaxed/relaxed;
	bh=85OFlzg3PfxyGmsu7FM6wtJz//OB1PuqzKjev30hWek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqET+Py6NCY186zCiQ/Zg6dzCn/ljx6/SDUtW/E2D1pmmv9bXAOI3q+i1xQbLOD+z+BgJZJV7B5tTezYjxTvKg3t2EUlDCkca5/A8s2zdcWS50gHSE8WTw8dO94DPs6KNh+BFw7MiVAPOUQkjiBfSIa4bL1iPUMc7hVU3Lkb7Y+VEFn+2SpxoXh+RnDLoXGQFjrZaM+34J0sXi8qiVgiLg0vpHr2in0HU3Amh8DLf+VaJRsRIWXmmfStgAQKvUEYHLHdPJEckfw/AFdf5kIfOOEuKbjQ5dptnaZJiacIJ9BvBoBnBQqAo3yDU7UR4i0/bLOnoVUNxX5cMo8idRhWyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KWekec6k; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KWekec6k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJyB61sblz2yft;
	Fri, 21 Mar 2025 20:41:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 14431A457AB;
	Fri, 21 Mar 2025 09:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77739C4CEE3;
	Fri, 21 Mar 2025 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742550059;
	bh=ZUR3lzcRBOLhjpUcQQNzMmdrN44+Szn9WQ+beag+iII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWekec6kxiYnlS7QZErXiNsPc/l2TByldwfMbfk5qxHUAVgfeyqbcy/No4TD6IzpW
	 RPKF5LBKYJsHslyHY0Bzz4grHOOD50zPUyM/uSddpo615o0g4GUAgkenCW6q3wpPDk
	 UAzZvSOJkj/s+iN8D8GT1SDzw4pZ6kzp855K5UF8OheTgbsMsmAZu0CHcBmV7JC15m
	 Kq7RadEydjN8AudHG/NHMC1n72vg/6XWa3vTpVB7e713qzCx7q5nsqiGHRwRbQ3AA2
	 6XYde8EJUS3Frl5/iEzVLcDKK8L94ffbnoigiT7PkTqMhfyQH4HD5JjNaWQaA0r23L
	 qbDlQ3Jfx7O9g==
Date: Fri, 21 Mar 2025 10:40:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Willie Thai <wthai@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, kees@kernel.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, openbmc@lists.ozlabs.org, leohu@nvidia.com, tingkaic@nvidia.com, 
	dkodihalli@nvidia.com, Mars Yang <maryang@nvidia.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: aspeed: add Nvidia's GB200NVL
 BMC
Message-ID: <20250321-romantic-gentle-octopus-4aacd4@krzk-bin>
References: <20250320164633.101331-1-wthai@nvidia.com>
 <20250320164633.101331-3-wthai@nvidia.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320164633.101331-3-wthai@nvidia.com>

On Thu, Mar 20, 2025 at 04:46:33PM +0000, Willie Thai wrote:
> This patch adds a binding for GB200NVL BMC.

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> The GB200NVL BMC is an Aspeed Ast2600 based BMC for Nvidia Blackwell GB200NVL platform.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Usually this is just one line. Commit msgs should be concise. "Add
binding for foo bar, an baz based board for making frubies".

Best regards,
Krzysztof


