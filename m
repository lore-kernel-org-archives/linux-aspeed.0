Return-Path: <linux-aspeed+bounces-3340-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CC7D4114C
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 09:34:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsHrR3vm6z309H;
	Thu, 15 Jan 2026 20:34:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768469687;
	cv=none; b=aUC1oIW7F8RcYlXZItqb/lvdIiwgywqoHrqZMtBYUMYBk48uhanrWSPJ/gljA7YqodpCCaErXk9eh4nu/QpUmua4jeAlJDfUWJ9HxYWsX18zQ6BRFIjrKTK8wJHiAc6sGHrWIO9bD6WYQbzjWV4olFMkgZXy1JOEMKBl5XgAyP18uNLZ8FhrQKMmRSejr8DrI/EwJQ5vvkF4k1Bc5/v3t4Lu7hbLDT6C8srZ/4kVrETEB6lNriUNNbRnyiC3YmqZx34u7aKJPeSTEEVABuqYT3pnkaSAZzugaZQG9izRG9SeiDc7w+h4GmdIO8hSZ39nVa9Tb6ak04kRbR/w/YMh9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768469687; c=relaxed/relaxed;
	bh=DSoMJgyUM0V7X4H/myr2OxM88Dt+xUMW8c1Mz+6vyis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anxy0ISYOasBIXv2Y0OXa5yCxiQPrguxEUpezszoBCCqy3gL8z1EH7EAKVGdMnnfDfHAMgThfjRJJex8yH36dg4DsDXE0j75MpkUA/DmihbblIxxx1MQOhJhFkOzoLfXEYfWJ0ufbi0Rjm2GyJAt4PSN51DLB1MBZMAP5fCXmckIVlVkWwzFRlnkf6hbYsjWUP3mdUDA4Q+Bzg8NV+CqD6a4A9R9UrEcLGj0tScf7ZgtU5X9FSAYsv/93HSITbz3CbnGJe4p1uKLVzfDDJ0jXeIjRZPk8Yb04Xg9/uddG+VXl4gkyXl375xi9XGe53Mxi6WMutSS+SrxSCOinRXAcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rpq9QmXE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Rpq9QmXE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsHrR03hyz2xNg
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 20:34:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 66F94443DD;
	Thu, 15 Jan 2026 09:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D8CC19423;
	Thu, 15 Jan 2026 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768469685;
	bh=TJJWJEH9cBep2QCio7p5rRyRMMqXshoNHerQDcCsLEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rpq9QmXEhO1Y/mmywYZKcLHYqrS4Y9udQggyp3JxZuN3eEYpGlx8CO2eKzUt4gf4R
	 5ZUzEhkv8s8+cEMEg/pXboVo55W8N4ZbHQKBrdE/E+Fne8PpAmXjre/B+lelNaiWOY
	 Szsr6VtslznA0YPtjTrkGVj7YqDaI1tp2+tFfRTTtgS0nO8D13V/y04fioC3Ti/8uS
	 xC/HD/0JLc31B6coh22NuUxnPkyWsPpA17P5MgPDrHvCVsviTIYO27+ymW1YDTaJTe
	 yR+ZKwpN71dYJvcTfY6DmDxGsXS2zbi23T+DW0lpRS3y3MnB0RuoOP+OjBtdERuPfl
	 VTjDhmKKVH1oQ==
Date: Thu, 15 Jan 2026 10:34:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: Add Asus Kommando IPMI
 card
Message-ID: <20260115-illegal-sweet-skylark-bc2a92@quoll>
References: <20260114-asus-ipmi-expansion-card-v2-0-12b72d20a9b9@gmail.com>
 <20260114-asus-ipmi-expansion-card-v2-1-12b72d20a9b9@gmail.com>
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
In-Reply-To: <20260114-asus-ipmi-expansion-card-v2-1-12b72d20a9b9@gmail.com>

On Wed, Jan 14, 2026 at 11:31:07PM -0600, Anirudh Srinivasan wrote:
> Document the new comptaibles for AST2600 based Asus Kommando IPMI card
> 
> Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


