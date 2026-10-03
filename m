Return-Path: <linux-aspeed+bounces-5124-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB24CA5FEC
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Oct 2026 14:41:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxpHT0Rdrz2y32;
	Sun, 04 Oct 2026 00:41:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791038469;
	cv=none; b=onn5646YNeXS7CCUxQ1QTLEoDbDAm45qbVboMcGd2eS3xKFw5wPlS+OkjH6caAilu2vSRTX0jhjxQdTOql7aSLLBpvcdzgpoM6isOhilMKHBdMbOtOT4D7tLxuvpD7a19bshtz5JBL5IEtkfA+YWx7Bq0fljxP7MDmjBwGDLms3vplnxbjEeZarGTPMzXbguD0I7qQfmCXnlxtvqyrs+4Uj3+ZBb2H/sgRcIAZai1DJf/4ciQnQnGlAsk1JtYn19UcpGk9+Ru8rG6dmicbm1hdAzq+SvwTMTmWBGclz3bBatxhbGO2KFnd0UX27TeGzSTb++2895/ZanUSI/bdfLsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791038469; c=relaxed/relaxed;
	bh=Za1pZegFszNhsXf/v1xZJxwhyF/n2vi12w8ByATTNQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bqk6VGlHG4G06rm4iv4H37MDVjE79GYGY7YGWbjojQv+XBQJfdXSDRnwe69caNCAl8NqN9CAQEv7KNB1j4TCvCZxxs7vToZX264gBiQe8NbNbqfUTgy5F9XwUZxaBJJA9tENtD2fPjpqGqkC11J636Lf314nuiJH23Si28Ff0Sw699MxzlYnqIhQb/Rb0yxChecZ/UUgNQJC3aiuxKNuA7GG/y0s9cqOdNAcjzlhy5pSv3pou/p0TirC7fPeFG/wbl2T9a4JbAmQqgpzqEdGiceDzQ5wouBZD8WD1xECaSSLx99/+ADFt9KswSL8fK3fewjFR1u6N3yUwkQERbchCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nU4kZ3ol; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nU4kZ3ol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxpHS0QLhz2y2K
	for <linux-aspeed@lists.ozlabs.org>; Sun, 04 Oct 2026 00:41:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CA94F60D82;
	Sat,  3 Oct 2026 14:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32811F0089B;
	Sat,  3 Oct 2026 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791038464;
	bh=Za1pZegFszNhsXf/v1xZJxwhyF/n2vi12w8ByATTNQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nU4kZ3olmxqRaWGh/BMyUHNDmUetS5azGwKj+HLbpDQ+6CwqJrNiiXtOqPvtCxGby
	 n8C2YQcakn+dKgddXQgrFasrajHZTSYl95IkQg/PrhO1L6/BYRw3sLgjV/d9+wR/kl
	 n8HpXYCJab/uHaIQWOvLOIWtPBMYrOFV1pkXjjFG7fvRzNEAlamHlU/QOwnW4Z9z/Y
	 x+2oUmN4B201cIbsl2ncSI3rnvDb7c6UJrkhBpK5YhRyL7Fw3lOBK9Xo0Y9BFyFStF
	 pNukhjCLyv9PkPaDwwRLvjBlF9eDfu9C/LpoKxHlchOfR4Gulr7D/cri+QLY+T27IJ
	 PsiNQffNRWcjQ==
Date: Sat, 3 Oct 2026 16:41:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dawid Glazik <dawid.glazik@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, maciej.lawniczak@intel.com
Subject: Re: [PATCH 2/4] dt-bindings: arm: aspeed: Add Intel JNCRP board
Message-ID: <20261003-convivial-mottled-turkey-d6c932@quoll>
References: <cover.1790344811.git.dawid.glazik@linux.intel.com>
 <212171467173c9af64b3f8ecddca2a445b7e7148.1790344811.git.dawid.glazik@linux.intel.com>
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
In-Reply-To: <212171467173c9af64b3f8ecddca2a445b7e7148.1790344811.git.dawid.glazik@linux.intel.com>

On Fri, Oct 02, 2026 at 06:32:43PM +0200, Dawid Glazik wrote:
> Add a compatible string for Intel JNCRP BMC board.
> 
> Signed-off-by: Dawid Glazik <dawid.glazik@linux.intel.com>

Squash patches. You don't even say anything useful in commit msg, just
repeat subject and diff, so what is the point of having it separate?

Best regards,
Krzysztof


