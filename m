Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255C606AA02
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 Oct 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=GmoI/5q1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8F0j0V4Vz2yD3;
	Wed, 21 Oct 2026 01:19:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792505972;
	cv=none; b=fZvnH4Ssw/OI1coXjAszQXn5bwA/7udq6/sx7b/mbLS2jToaQgGrb63g86bFfTE/rpD7vL64Py4loyWOudLU5sRP6f4sbDh+R3vTfBbWksU16uqze/1kjSKitPim3kZXOgIMGTpo9xPTioy8pDIuPA7ubkO5e8lI462WFFmU4DCCwYoqlrh8LkkkNo9hPCpl0XpJhJ4pIqbz3I5FUkkpOuHqvPYPQNeb1Ly5fH07REpR4ieJfm/fcYQntWz5aRdfJHQAyzBJGnzACD69xb7zjHfwCpiExqvyygtKA71cj/TujKbSuCUZgAOzsDKC7+vro6/yTVWAUmK2ZpahahkZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792505972; c=relaxed/relaxed;
	bh=YkoDoRI70vCTaQBZvsRQEGTtNXqyblBPUwYfPQEb34Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcUNQ7lJ8uua6cCysO+TEiLNTN4zzhbHo1XophF0vSdyyz6s0SGzqp+QC6edLGjC6xZ1Vwg5W+geybZOQ+Sleyld8JosvqsjgUHOXAg5fNioLGp1IRdNi4t6HkWKQCUCWVSNYsF8Bfy3aZKg/Em+Qouar2BE+WvyMWeQhyGZHVPWfXTtbIq1lrsFS3z8crYc14Gr86V1Vlkz7BpA2Usy8sb0RK5O+L81c+Z5NXU9w4GG6On5SSrcueffnZ38WanSgi35ExjBjRnjB8dHrgoXsmKX6N+IVh9DA0LucRTf93lNT7e0TCErvK0J2Zv7QwNIR0aEB4XLddQKKemw8OCLUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; dkim=pass (2048-bit key; unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=GmoI/5q1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=stern@g.harvard.edu; receiver=lists.ozlabs.org) smtp.mailfrom=g.harvard.edu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=GmoI/5q1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=g.harvard.edu (client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=stern@g.harvard.edu; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8F0f101hz2y2B
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Oct 2026 01:19:28 +1100 (AEDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-91ba702cceaso37764906d6.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 20 Oct 2026 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792505964; x=1793110764; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YkoDoRI70vCTaQBZvsRQEGTtNXqyblBPUwYfPQEb34Q=;
        b=GmoI/5q1CmEErulBUjNdSq07kbX+wRX5v1XEQ/SBz+TEJGiqSQzDPjo2J0zO2uDw7K
         Pl0fdHql08cZWhnUwwcqTUMWxQxlmAWGv1kavVP4LZOQZZ9UjYCT8w+M4Rj73yTHG+SK
         bpHvLcohZbZfyKY4j1peIk1UpnoQ51l0D6DOMYor1XPemVszKDw2RvC129Z0xykWPcbh
         Vlm1Z9jojMNno3KVdbX1eDuRjrXnOY7nXVXC/AXM1/ykobSUzK7QgVMJm7Cfsp0d+ffN
         qM4lOUlw27iCMys6YbTBN54AtL36F9W3m1v6t2X6E/3eEhK65thCjFVjkVs5aGAhTF1f
         VTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505964; x=1793110764;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YkoDoRI70vCTaQBZvsRQEGTtNXqyblBPUwYfPQEb34Q=;
        b=TbKduv4YNbaClPWWeXokuCsjjq0+kPVzkPWLu6VxaHhXns+nYOcZEVUdgMKHmRwBJP
         +wcLgE6WfD37cqCcgef8P83vAOZFKd/PZSilwZdwP+SZZGQ/JxLd60SMBlrEW+Qvz7kc
         jgLoY86W58xdc9aASz/oodI4VI7cHvQLmK8raZr2DkBNBxFevSi5lHA4rFlUjBtvMuRH
         Jhs1HxVw/khYkhPp8QLNPxuj9v17q1CIWslIGaJOY2L62/h/CL8XZu/CmXjVyYFb+rjL
         HWRrazPtUyMmLp3r6UtdSwzbrF0yleFyR9Gt63Ptf2jN0DPNM6SbIPHo/4Noa7QuGWcK
         bCqQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhjS6Xl8Nr1LCA3umILvfd/SqeGsU1BjL0FI/ogVlF8kNfVXISVNndQ+/zS7LPL1KENPVY2hBk1CQusC8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLRiwBMYdi0w7NV1LyyUWTbn9G0LUK4oLKY2r5lKG3r8Me3u108
	YEjBiscQDz/7UAy8OSSf/+KeCwLDYYukc4AvmzAoVmReHBpCNYxlS49A9JmqN238zQ==
X-Gm-Gg: AYBFou0DcAYyXunzkyOkjmm5WGLBKh4KgjV0OrMiak6UEmSCjVfwx8xBnjVD3FrXeFF
	S9cTmsmJpzhrpxd9vjIFQf/0Of6TzoAzjjI+mPcerhQZUd4bFAmhna3E/v12KZTou56ZkGmirJ/
	Cm9xLr/psu1mvwzOdHaSHjNUhJrwNNSHWY9Xh+z0Dn5Sy1y6ie4eAlZ+2PjU6y9fuOpXxsSuHqb
	9tPof/05ar/71pRVfjJsv0O8qYfaW8KX7dfuPrjnr3+9TOy2gBS+LTt48ufHmaNPrLI/m3RvUGI
	qeY8ucZewv6jfcQXOxbBELaLzxzIKKJ/u0q15jNmK2PEkdJo9Kk+ox8StyvbW9Zxji4iMJ00YyW
	1rLZeykXC1JsckPrLAl6k8Fxg6DSWnstlaCnCcrsJFqmj8id70aypVsne+vfMpapCUFSKIGdxPj
	LVVEaeHJN0kGp83lpvVl7JQ60deGqqcgtSoKdHM1nXErkJAqm/7gtdZpoixYdsd3a1Yprjz2wy
X-Received: by 2002:a05:620a:3711:b0:93f:22af:cce7 with SMTP id af79cd13be357-93f29b48f0bmr1804346785a.12.1792505964411;
        Tue, 20 Oct 2026 07:19:24 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::4791])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b10563fsm227100085a.43.2026.10.20.07.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:19:23 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:19:21 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Joe Wang <joe_wang@aspeedtech.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: ehci: Quiesce ASPEED EHCI before halting it on
 shutdown
Message-ID: <8e2fb3af-3bf9-448a-a6b3-16f629417152@rowland.harvard.edu>
References: <20261016-upstream_ehci_aspeed_shutdown-v1-1-8440c13b5652@aspeedtech.com>
 <7dfc5ef1-a466-4d78-af65-147bee8fe698@rowland.harvard.edu>
 <OSQPR06MB725090D70BB07F70A2B521E789672@OSQPR06MB7250.apcprd06.prod.outlook.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSQPR06MB725090D70BB07F70A2B521E789672@OSQPR06MB7250.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 10:42:55AM +0000, Joe Wang wrote:
> Hi Alan,
> 
> Thanks for the review.
> > 
> > Under what circumstances does ehci_shutdown() run without ehci_stop()
> > being called first?  Is controller death the only possibility? 
> 
> No, it's the normal case: ehci_shutdown() runs from the .shutdown
> callback during reboot, poweroff and kexec, where the HCD is not
> removed, so ehci_stop() is never called and the controller is usually
> still running with devices attached. The issue was seen on a host
> using LinuxBoot (NERF) firmware, which boots the final OS with kexec.

Okay, so this will slow down a normal reboot or poweroff.  Hopefully not 
by very much, if everything is working properly.

> Controller death is mentioned in the changelog only because relaxing
> the check in ehci_quiesce() also affects that path.
> 
> > If the controller is dead, will quiescing work?
> 
> It won't help, but it's harmless. The death path has already cleared
> CMD_RUN, CMD_ASE and CMD_PSE, so ehci_quiesce() writes those bits back
> as zero and the handshakes either succeed at once or time out after
> 16 uframes. ehci_shutdown() already touches the registers through
> ehci_halt() in that case anyway.
> 
> > Is there any real reason not to do this on all types of EHCI controller, not
> > just ASPEED?
> 
> No EHCI technical reason that I know of. I limited it to ASPEED because
> that's what the report and my testing cover. Since ehci_stop()
> already quiesces unconditionally, doing it for all controllers should
> be safe.

I think it makes sense for the change to apply to all EHCI types.  It's 
not really a good idea to leave an independent DMA master running while 
the system is shutting down.

> > Don't you want to check whether the controller has already been quiesced?
> 
> The quiesce has to come after rh_state is set to EHCI_RH_STOPPING;
> otherwise a URB submission or hrtimer event could re-enable the
> schedules through ehci_poll_ASS()/ehci_poll_PSS() before the halt.
> That's why v1 relaxes the check in ehci_quiesce(). The side effect is
> that a controller that was already suspended or halted gets quiesced
> again, which is harmless but unnecessary.
> 
> I see two ways to avoid the extra ehci_quiesce() :
> 
> (a) Keep the relaxed check, and in ehci_shutdown() record under
>    ehci->lock whether rh_state was EHCI_RH_RUNNING before setting
>    EHCI_RH_STOPPING, quiescing only in that case. This is the
>    smaller change.
> 
> (b) Same as (a), but leave ehci_quiesce() unchanged and have
>    ehci_shutdown() call a separate helper for the schedule
>    quiescing part. Other callers of ehci_quiesce() are then not
>    affected at all.
> 
> Either can be combined with dropping the `is_aspeed` check. Which would
> you prefer?

(a) is more reasonable.

Alan Stern

