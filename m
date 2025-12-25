Return-Path: <linux-aspeed+bounces-3212-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E9AD3B7E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:41:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dff7m6jkPz2x9M;
	Mon, 29 Dec 2025 12:41:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766684766;
	cv=none; b=Knu3hIhg6Slbc+fUtTBkTpQCt90BMn6ICnBmRJJQSbn+JeKj7jSiBto8uZFRqigFP7D/RmRv/Xg3fXayMOAz35LrXPXikKfjU9BN0zErsP+ce9/sUReMTYS8w2Pq+EyXMM2vi2ePy6JYvOF1uNL8u3+bimt4COcLQih28Rw4zpLqouESGpKaSLC3+z+S+VAvdYc5BMLSbHiSD7G5MO/njwyCj3SVTe8x2+4rF1/DA3p7LHtLaQ1EuInNGM0v1o9OJ6nGNdnxdZq9cBXfaBppM+mtGiSd5mDdzb8OBvaASWjcIXCmRG0B3UVHteThaaGv6XXrCwz/YP5EKZyE67E+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766684766; c=relaxed/relaxed;
	bh=/mLLHQ0NYNnx/EzrQbuQDe5XiynoiftrV7RLmjK4LUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LtLdEj2zD+ephw6n8BafleA3Ove+UoXiKbu1j1l9yvfNTOcts0PQfysHPNCEipIL9JvVoiv/zLyByw67busZGUYjSpNEI8Wj/FpC9ER4TPe2sz+i/4a1Ckrd8dXDSLmal3Zcu9zuoqVRA3/ZcfSiF4lUmPnzouEzMtRh2QQjVIAAKP7sE6gNBdzV2meXU5HErfbt6mjIHgKjhhGaHe8ayZUjUakxBEoGI/VQuSpNafhlfcU76dDgLi5ZsxSd65gTIGd5K5PHD2+wtNjRL8kfPeMjZV26YhNebegzrE9GFbCobeIxrgm7y2XPy+560ZsiVzXYq7MdVl9ezd0VVeWZqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gC2ugUmV; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gC2ugUmV; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gC2ugUmV;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gC2ugUmV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=bmasney@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dcbl04lPvz2x99
	for <linux-aspeed@lists.ozlabs.org>; Fri, 26 Dec 2025 04:46:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766684761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mLLHQ0NYNnx/EzrQbuQDe5XiynoiftrV7RLmjK4LUY=;
	b=gC2ugUmV/q9U13M8sNy5bNNZmmvc64T8l0EAJ7lkqNevEeEcIqUZjjwwJsNEvDlyxuJZ+w
	OgHMDWuxuKE/YjN9/wah7iXtKIobCP4lC6F95R4gLhHVpl0IteqtjKBv5rRg65IkvMnznH
	zhRm2Gm5x3eRya+gkBHBuu6FjtSG7Es=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766684761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/mLLHQ0NYNnx/EzrQbuQDe5XiynoiftrV7RLmjK4LUY=;
	b=gC2ugUmV/q9U13M8sNy5bNNZmmvc64T8l0EAJ7lkqNevEeEcIqUZjjwwJsNEvDlyxuJZ+w
	OgHMDWuxuKE/YjN9/wah7iXtKIobCP4lC6F95R4gLhHVpl0IteqtjKBv5rRg65IkvMnznH
	zhRm2Gm5x3eRya+gkBHBuu6FjtSG7Es=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-MgZb1bEiPn-AEw_0yz-M1Q-1; Thu, 25 Dec 2025 12:44:46 -0500
X-MC-Unique: MgZb1bEiPn-AEw_0yz-M1Q-1
X-Mimecast-MFC-AGG-ID: MgZb1bEiPn-AEw_0yz-M1Q_1766684686
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b51db8ebd9so2142628985a.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Dec 2025 09:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766684686; x=1767289486;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mLLHQ0NYNnx/EzrQbuQDe5XiynoiftrV7RLmjK4LUY=;
        b=THCs57BhKMR4gKjBZDk/D24VNn3uy/+Bi0FDhLQYSkbDS0Gx+JbpqKeplbUIFAByEd
         d5Xr8cok7+ypLzcPLc7TiAXrnus2OSkgDQz2py5OMCQg1s982MVLIq6MEtFMzhkjArdP
         GaAbMYbWExF1CT+G+0k6NsqRUB14Zfxa8xByAkFoL1vb7gqKFtBlqpaKceIB6wO92B0U
         L1ko4pHfTgrSKAJrKWhwkPIcoizdkAsIZ+KLoC4qA5ptoMZiR+dOqgUuHcWEk7yx/Ty5
         zbPHIhRf2j1EhssR1cdvtCj27THEXgnpK7nTktoEy4M8pUmChVoaPgxB0a3phVD+bM6s
         +BaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqqJPsg6Z2ETNlDNUKokTPtuhYqsCrYsYNoAknhaPpYqlJS7X0osqnYq53Qnlg01afNR2vExOzm5YT8Ks=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxX7QkMKggYdQNVzIU7gqkXkiOlf1FqGUmHfRj0ibrgkA6x7lGA
	4EAiR6yG6/zUKNqPgc3cf9oackNtoqX2X9LHXlAfoto5V7oSxVLLrbgdFYQGLoF0LW3DfiTAK2z
	Ze7Eb+O7VeMwN3l10Izm9H67ovg0h0gRr/0BD5KrLYwt9rF4RMY16wtTpNPmDRMrbb6M=
X-Gm-Gg: AY/fxX5Wqzj86EbjyikTtm7Bv+Azhpe1EkCnOtO7dNdpYBjl/3lCkQKw2x07DPPV/yP
	AdynMCpQZ3e2UTnyfEH57n7pQAVZ/kyoKi0Gq8JUOHkjvSE9s+3LdtsLQvqwh2+atHFUdroNtK0
	fmuth/5XhEZV0A0OPXd/YTHQcjA+T4802NZLk6gzNEyL0mwwvy9YKdYCKuQAwv1WwiOR+nUMV6u
	7vIp1K7k+BzUFQFIBgQaN+/g7BnzUX7KOvc43Ew7Cp/T30JTjw2IICqw96f5veDvLHGUh1+oTLC
	ZJ2TXiui7qtRjp0RMJPh0NUffctE2iM7l4fh5OC0bDGTjWA0hjELcVqwEouz2x0gYcvQIm67eBN
	+TjuT4tYNRGTZL3wS2SLeO50BxjQ8qgeNyFxhArsZEv/9
X-Received: by 2002:a05:620a:7004:b0:8b2:a049:4ac4 with SMTP id af79cd13be357-8c08f669593mr3067406585a.27.1766684685779;
        Thu, 25 Dec 2025 09:44:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG/L5pwoLwpBSCZLzL63JBIDFsHP5Rl5s8WLau2qn2BvQm1lxuhkg/jnhZdcw24cYGOmLPqg==
X-Received: by 2002:a05:620a:7004:b0:8b2:a049:4ac4 with SMTP id af79cd13be357-8c08f669593mr3067404285a.27.1766684685324;
        Thu, 25 Dec 2025 09:44:45 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783922sm1560042485a.7.2025.12.25.09.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:44:43 -0800 (PST)
Date: Thu, 25 Dec 2025 12:44:41 -0500
From: Brian Masney <bmasney@redhat.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v16 1/3] clk: aspeed: Move the existing ASPEED clk
 drivers into aspeed subdirectory.
Message-ID: <aU14CWYXtU6MhmhF@redhat.com>
References: <20251224-upstream_clk-v16-0-8c1318f56c3c@aspeedtech.com>
 <20251224-upstream_clk-v16-1-8c1318f56c3c@aspeedtech.com>
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
In-Reply-To: <20251224-upstream_clk-v16-1-8c1318f56c3c@aspeedtech.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mG34wOKET7r0M3zw5Ehvnjg0-nZ5fh05DKDal8a3qQU_1766684686
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2025 at 01:37:22PM +0800, Ryan Chen wrote:
> Prepare for long-term maintenance and future additions by introducing a
> dedicated drivers/clk/aspeed/ subdirectory for ASPEED clock drivers.
> 
> Move the existing ASPEED clock drivers into the new
> drivers/clk/aspeed/ subdirectory.
> 
> No functional change, file move only.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


