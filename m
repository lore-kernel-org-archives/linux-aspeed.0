Return-Path: <linux-aspeed+bounces-2323-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D18DCAC592
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 20:58:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVwSC07XPz2yxN;
	Tue, 23 Sep 2025 06:58:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758574698;
	cv=none; b=ew5KkkvvdAm/KByf1z3/ZDh4De+f0gGZCGL5+ZMqyfrknCI8PtVFOCcQOILn0xyrYZdxxe6xlBAXIEsdqIH/3y9dfGKY6HAbH+GZJjXGBnNG29E452ldDxDb7tCrjP6cIWsuHxy9E5WII8UK2B/sbaDPuxW6MmuXRjwZdOUm5awalOmKLx50SYfaZwjS8n9Jk6uV6Wvx5r3mMh+wQBeERVl5XOtbVcTdaIlu7YsEjchQkG29/K+T0uXF3itDSN9gnHkeunaM1VWaTErg44vV/ltBaCPgndyoY6Zrz7DcX5rBNuE51jIWlyoTuqwSnVfBCN3qJaULaNtdwrmx8832LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758574698; c=relaxed/relaxed;
	bh=4fvN8CbudCsrlCP+0WfaQGjx+Q7MToLTTAQjRp7ylO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjYyVUiIjPpu+7JLMDybNwekYFxIYWgs4xO+QacEBRCIZQ+pD9171ZjPYFBqiPR4/MAFpXIMzH6kHq8Mt5zhhxGV+UhqizCeOHKG36DMKXfvJbgIxKgFfrUfvStWahC0azJMAYoZwjgTGiLJnJ/is4lOMBu3PvjfN++Ozbp2MV5cmboJfpUy7JT1ebhtVM7bcqAkzgP7QtNHF3Bv9csFXpAuNu2oPx430E5r3o0OT9Cy6n384bt+0Agej6SAuVA49sk1W1zjG7vljdk84xiUHDHcXlY3vgVNEL6kHZ35YPV69rhlmZqsHI9P9WPEBXeJbTK9O+kX/DHhIbVAiAjaBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m4RstmgO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m4RstmgO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVwS96sCsz2xnt
	for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 06:58:17 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8945F450AC;
	Mon, 22 Sep 2025 20:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC2AC4CEF0;
	Mon, 22 Sep 2025 20:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758574695;
	bh=a2EzQ2feyAihhU7qeCv0457wm3+uh5jWnvFmyEY60gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4RstmgOxjwBOO7P+lNGUfj0U9lHz1Sid69uTlLTcR7G5hSChZpZrCcKhSdEj5JWz
	 SMcrCaU1vTYw/lllhxEVUkxREF2te7belUp11deyGrtlpWjxF7i75BSnR8tF8Fb6Vr
	 5gWL77IwNOI5dtE3x1VcwF8Dz0+Uc/cwAqLGbpvOUKlAXPq4Q8CAXSYEveLLe7sIUu
	 dN2p2yYXoRDLv32fQw1vjrPrPNhrd5pUlls666mi3Emfvgx2Gij+m2PFCZwN7U/hxj
	 deZf48P1HRwyyFMlkTBDzZANwIz3qSYNosqOmWnV4AiPz+BD2Ly81V/mq9vBjWb9h6
	 ONsTt7m9X2JvA==
Date: Mon, 22 Sep 2025 15:58:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: conor+dt@kernel.org, andrew@codeconstruct.com.au, krzk+dt@kernel.org,
	devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v7 5/7] dt-bindings: hwmon: max31790: Use addressed fan
 nodes
Message-ID: <175857469316.1311709.16344129263552911136.robh@kernel.org>
References: <20250922175804.31679-1-eajames@linux.ibm.com>
 <20250922175804.31679-6-eajames@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922175804.31679-6-eajames@linux.ibm.com>


On Mon, 22 Sep 2025 12:58:02 -0500, Eddie James wrote:
> Since fan properties can include reg, the fan controller should be
> able to specify address-cells and size-cells properties and use
> an addressed fan child node.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/hwmon/maxim,max31790.yaml           | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


