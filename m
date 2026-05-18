Return-Path: <linux-aspeed+bounces-4057-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8515CD4F52
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 10:57:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJvsW0z7Sz2xpn;
	Mon, 18 May 2026 20:57:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779101871;
	cv=none; b=h1U+BZKENtMqaolhdCYsMJV2ynjPPsACa963cWE1mEcKkuvqi7jj7QGu/7+xS9P7pPT7KToiJrzKRCE2pyKZf3cNALqz/mUmJ01abKN/c6222XWITC/ksKrhbCB23kkZth6bta0Soi5HfFHS7Y5e9KxM9ytUlyWY9qmg6+GrshB7GQ/RkvV6JKotiSEL/sqUk57GOu3CtMFKpQulQ5V019q3PUAqFPVNMOWrh4VCZixN7oS2kUQq1E4k4NPj6BtLGg7cjSwhxZ6c03j6kM3nXA9iPLFVBI7X3m/r9FQmP8qlmdcjV7Et2VmliogVRF6xn2GRBSxL7KjFnsuVr8yAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779101871; c=relaxed/relaxed;
	bh=5dOCLLWp9hX+ScYi36iKJw2FCNE3CLNX4EfhzNUCJOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYcp16Zt7b59eexDVCiG/Tf9E8Bm3hraeQuetd/OeaA4iEy1L1oreUuf1dek/7AZIbsykNtflUcuWA+K20muRq6zpBR5V+mdMDAEF2xKu917MWvY8wSSPd4YnB+N4TU8DBRgTbQSIhzxGwulRZcpivSpKwqVhFDaxnSTh4tsV6jfvi4/InIg1K1p0yz0LXskUGrSOvLYuhGhRhQKf2KcvZ26ntfd6v0zw9NoNnEJnOUTY/OT1vbBvTJwix2KCTeU2BdbwfLwizTXb+CkWuuYGyEryH6tcRdfQuNpQStIIkA6hOl7p2n82Aw0IUn+SVOpfsfE5/Q0plmQmp4InuE0dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r2ggqCdd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=r2ggqCdd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJvsT43VFz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 20:57:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8D01444439;
	Mon, 18 May 2026 10:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D93C2BCC6;
	Mon, 18 May 2026 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779101866;
	bh=JiBPOxZLEDKT5kX2bjKy0xlL68o9NdQVT3OXuYDckuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r2ggqCddi0IZTwwgbQR2LuWpErM2pqvyKTv2K3zWQgPatnKIgy8IHSbnBlnx9mu/V
	 o2vgcDL8bbl/sIXUuo5mId3RmllZT0Kn6EImrwcaqXA02sV1VrI4pxBZoKEQpjLPzh
	 yZpcKCugwbwUti2U052+3jtIC9sPNolcz+UJCsS6AywXzyTCjhpBP6eIsrH7oKney5
	 0gKxa2JPSrls3BGFEmxDeckFtkm5oU7DDxyhAP8UNQVG88Z+kagJxgnghvKALPycLT
	 xfWkIZfstLm9cosgPoTTDJKWLE070S2UGCu1i38UjOftmx7znums1RrfueIMi8MlS3
	 5wGtN/SMjJQLQ==
Date: Mon, 18 May 2026 12:57:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch, 
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
Message-ID: <20260518-rustling-watchful-viper-b9c4b4@quoll>
References: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
 <20260518033440.17569-2-prasanth.padarthi10@gmail.com>
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
In-Reply-To: <20260518033440.17569-2-prasanth.padarthi10@gmail.com>

On Mon, May 18, 2026 at 09:04:39AM +0530, Prasanth Kumar Padarthi wrote:
> Add the compatible string for the ASRock Rack B650D4U BMC,
> which is an AST2600-based server motherboard.
> 
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> ---

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions of patchset, under or above your Signed-off-by tag, unless
patch changed significantly (e.g. new properties added to the DT
bindings). Tag is "received", when provided in a message replied to you
on the mailing list. Tools like b4 can help here. However, there's no
need to repost patches *only* to add the tags. The upstream maintainer
will do that for tags received on the version they apply.

Please read:
https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state in the patch changelog
or cover letter why and what changed.
</form letter>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


