Return-Path: <linux-aspeed+bounces-1756-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A86C83F22
	for <linux-aspeed@archiver.kernel.org>; Sun, 20 Jul 2025 23:53:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blgMd1wrqz30WT;
	Mon, 21 Jul 2025 09:53:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753055597;
	cv=none; b=GMRZ4k2/hdNITm4mndV0EUagdAec2neKGKskbKcZSZY9yjjm15/q0C2zbj3kLhAsyDVBlaJnGY5M1YjZYLNr42s65cKavJn7YUvunkeHYsTIW5Imw8b2s0tG8zWlKbW7gLFdBNW/UQjroR0+VeJCvn+LBuk8AVmKeUOKkycyv80+JneFGuFszwqG/5uouZPexRUWG3tW/sCO4snbnj//UyZLz7lWDzbk/uWI4N16U9RKqiHHDYEe/HbuZCctB25GJygIouPPkZ+m7nM+COXEauq1PuXxTjdmXM2xEluE+yrDrjwccbFZVQgKOhiG6X9Q27YVP1sK5pVLQnworbcPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753055597; c=relaxed/relaxed;
	bh=jQBOro9F+MQuOHq8M96Qw8N61+pxhdSOIRbBbM/x8dU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DreGc0qoXcLP8BboJhUuezh/Leoq3HJmutX5lRNKFfCqKuzrdgEiuii/OIeqMiRgwvmc/odop0atsegvxTRovQZyWBeJuqSTafoRgK+v1Y03Auckb4q+8xc+mahaERTJdrje/h77Cbl6zKp9LZtXt68fGejyT4rWlvqi8cShF9PU3m9/ktOBIAGxnYq4usUM3qma6NZdWKcGpp8iXckWdPdRfpd0535sAXpgf3lZlZMv4AjrERRMoqXyJ+Et7SZ1ooN0Fvw8dLiKbt3WRJw8lfdFs/YyWm8oYqpRDpt/4W+13RWqQrT+3BSx54HPdH0RhuzcAqPihWGR99kKKX+7Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MRsHJ5iZ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=MRsHJ5iZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blgMb2BsPz2xgp
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 09:53:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753055593;
	bh=jQBOro9F+MQuOHq8M96Qw8N61+pxhdSOIRbBbM/x8dU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MRsHJ5iZcwN7AfQyPyK0F2DbDWKlN516JqHY5HjuJpExPrJPh3NkdY4x3eYr5HuCK
	 rzQpZ0j/DSf7eVuKblwvW0hHcdcssQqUW0PcqYDKzVOr8u3pZKNFlWLVxvk2s4ZrDH
	 NHIUF7lhsQZG7pFRWF3oNMAB3WKLIwS1kqvrji/kMFBN3ljhEgbFfLvwQ3nHQFLRkW
	 2+HwQTjHSCDouHP9iHOdVJIkKB39WNjsMbmdrjeItdHUlCk7gTywAJbSGe/S85R+xr
	 /Y+FAx2SHbRABITnBYUxsgBU/iudzsMvVa17cPYcxS5t+Ci3UJT6JMHvwqxVUjkxDb
	 H2i3EFOYwGjxQ==
Received: from [127.0.1.1] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9B2436443C;
	Mon, 21 Jul 2025 07:53:12 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Joel Stanley <joel@jms.id.au>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250703183508.2074735-1-robh@kernel.org>
References: <20250703183508.2074735-1-robh@kernel.org>
Subject: Re: [PATCH] soc: aspeed: Use of_reserved_mem_region_to_resource()
 for "memory-region"
Message-Id: <175305558159.1020373.9271236318462742119.b4-ty@codeconstruct.com.au>
Date: Mon, 21 Jul 2025 09:23:01 +0930
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
X-Mailer: b4 0.14.2

On Thu, 03 Jul 2025 13:35:07 -0500, Rob Herring (Arm) wrote:
> Use the newly added of_reserved_mem_region_to_resource() function to
> handle "memory-region" properties.
> 
> The error handling is a bit different. "memory-region" is optional, so
> failed lookup is not an error. But then an error in
> of_address_to_resource() is treated as an error. However, that
> distinction is not really important. Either the region is available
> and usable or it is not. So now, it is just
> of_reserved_mem_region_to_resource() which is checked for an error.
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


