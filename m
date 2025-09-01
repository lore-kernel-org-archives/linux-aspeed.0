Return-Path: <linux-aspeed+bounces-2108-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4C5CA100C
	for <linux-aspeed@archiver.kernel.org>; Mon,  1 Sep 2025 20:29:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cG0pN74v5z2yqh;
	Tue,  2 Sep 2025 06:29:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756758556;
	cv=none; b=fY8wWCkNWUcj2yAwpIYZ8CfTXXKzdDVRwu+dEKChYNnvzpt0Lf9c20D5udCB9XMJ0jOsS/pzxkyt5ZDkIRHWL0fFJnMExEBxddxR/4v/+RRZ0VRkuB1tOgvXH3AR7I+p9+AUPnU981u9aONxxTwaoN7vgZCQQ5CDFqoA3gMf1CcIGPLBn+LD8DeXuOSBcUpkKzaCK6l6Y3NmMfwIeD+3LIvNZvNmzvtFEKJIddEI2ZJfG3hT2Z7YyWBm9cK3TE+eZI4SGkol240olpxfRkYRRiP2W2olG4kb9DYFFgGFQ3vPxMoJPjJW2tKTgADa27svrLqNiYlZ0wogcJoENB4DSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756758556; c=relaxed/relaxed;
	bh=+AbE/75K2GVqTBVNgvpt+w56HmHXmLPpo7k65ZoP/Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYG5GKTxfFPEUGk4xEymO3yDpZyeo/jL8m38UuzWrtP1XfFuJJWwFS/kFDCq1suA/GRMdlD+MNJgsrWjxmtB5iB3lMukSdDBP0zh1lBKBNTGt+AgA1ZETjwbUhSC7WC94FBj/nM2cYUTSmktHg1IShu8JGfi5BL60cNqinNZ3afnYlcVcnmc4OdMAUUj8FB6dGRgfSlfLFXPb7drqO4VlDCUrcopw+Q6HJkqdcA7pPon9uKhR8mcNty0uLr+HAIxNk+duo7UN1db4yJV1PczuOYCbZimy7oiiYp43HPp6Gnl+1yNh2rJ/eUevwEUe+0iac7cR3ho5Bqul51BwHVwYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sOrMtuok; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sOrMtuok;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cG0pN3RMtz2yhX
	for <linux-aspeed@lists.ozlabs.org>; Tue,  2 Sep 2025 06:29:16 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E132B405E1;
	Mon,  1 Sep 2025 20:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E475C4CEF0;
	Mon,  1 Sep 2025 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758554;
	bh=xIsLH653UR9bpg6VTzgFv8umlPBg//nOtGBqWRExVFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sOrMtuokVlRFxgVNtMVpHJEVW3oVaxoEgCPwPi9LEN42ziu6Zc5t3rAmOk0Vo91T7
	 kHG+sVCbL2AIGFI9nAY+DYtZR5qXGISaie+hM3SkCzexv3az3cWCpM4scLm9dWFcj5
	 +8gymTMSRrS5kelGB9ECeoZjR1+bJ+ewRjaqF707tQ7RR6ZHmeaMrGDvqwOm0vnBQf
	 4sTNv4KGmHnJ8Z6oM8FWTKdlhJ1iC0YaqLhjpFM4T1nxS74gBOr8Kz4JR3aoJMSODc
	 TCJC0o7piMc4+GUfBl6/DWNtubQBAaF5VlTAN5NFd6/Lenf8/HTyxgpknXugarlCJO
	 7oh15BkrIBkbA==
Date: Mon, 1 Sep 2025 15:29:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: [PATCH v2 3/4] dt-bindings: interrupt-controller: aspeed: Add
 AST2700 SCU IC compatibles
Message-ID: <175675855315.287526.6300698694684294700.robh@kernel.org>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-4-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250831021438.976893-4-ryan_chen@aspeedtech.com>


On Sun, 31 Aug 2025 10:14:37 +0800, Ryan Chen wrote:
> Add compatible strings for the four SCU interrupt controller instances
> on the AST2700 SoC (scu-ic0 to 3), following the multi-instance model used
> on AST2600.
> 
> Also define interrupt indices in the binding header.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2500-scu-ic.yaml                     |  6 +++++-
>  .../interrupt-controller/aspeed-scu-ic.h           | 14 ++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


