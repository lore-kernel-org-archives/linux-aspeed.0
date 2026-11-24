Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BFE606A32A
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Nov 2026 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mu+lZvdL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fgKeFyUl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYXSC3dJsz2yCP;
	Tue, 24 Nov 2026 17:08:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795500523;
	cv=none; b=kfkTpA6cPVsWUWUmSu8CRRsFpU/mLpQaB6Z8BV4YvmCvhMZ2pQXfTLSG2hvHo8UzDfDbxbGLuzX2xB6xiZ1BohaJ/CS4cjJeBnOF8XXOuEl9fHUVrkSF0pOxwHpNl6QCS7mci+NN+QTvsNj/qSEoDMnC7Lkx/uF0FfHGWP09NrYW+Ji3/a+6P3182j+Q0aFqGIjmhRYnzqGNEeZKh6/OLfCxHT3FSsChh5Bw6H19hx+YCkOeGboWODO1H8XSonM334THA4rGNudgEDuK1Ks8ydaFfFAolToV8pF/gbjS86bEllgiiEJ+v4LGKjIj6W2eirQ3bechDHt0P8RCfRpqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795500523; c=relaxed/relaxed;
	bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMitgDu0IKqcxv14eFyCbUXmB2AzzF+moyWLGszOkdEJPCGoURxnOTkev0WTg0S8oMf8QvJmqzWnwkYrGA2LI4LxMWXwEfZ5HU2WmPZuSHQxjccH6tmtlYzOTIc1oeKR7l8ezbeBCfQbEZJZa1Qhp2u41VWiBiAM1zf7v8xXSlZ3GkJxPmt2zxxzCJVlbB131viHEOs6wQlv+zazJId9hHud33EDrNWPMZXZc4u+6tlvk6amGyqa0laa8/fAQXoj7rd6b2MffOHsFzutqely9g7hC07puGgo0r0W++2NFl7IXFXJ4/sSIliNWw9RddWbu7u5nyFi5PQjL/kXIdwKsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mu+lZvdL; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fgKeFyUl; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mu+lZvdL;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fgKeFyUl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYXS93p7Mz2y2b
	for <linux-aspeed@lists.ozlabs.org>; Tue, 24 Nov 2026 17:08:39 +1100 (AEDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k5Li901797
	for <linux-aspeed@lists.ozlabs.org>; Tue, 24 Nov 2026 06:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=Mu+lZvdLXuWGpOkRTkHFjM/i3/zxBEn62CaGxwiM
	4QAwVoT9XEi4yAVQyTS/Hdf4oK6g4Bc9UAYdPk+DRdycbrtCTJCG8mMPRAhd8Itr
	YJhqFMUPxIvAUoO28f/gr9kwh8uoUQMFVNIJ4mHntvWYoUNjLLZJkNIL9C5NO8j5
	4wzwAtnHxt9pAGjuHvdm/dL4ZGq7SYRNZIslZ6b/jAPWSWpvoexho/kIjWyCe8Go
	XEM9WzZZfx7YDi8VBJiRGkruQKiQYtAWiuR5g/M2YJX70BEeqYi1vnUAfiYQx25H
	1Q6Q3rvSf1diwPrHavfw3ko6BktLi1o93wWElVUR6hp2Ww==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6sspr7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 24 Nov 2026 06:08:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f26dd2165so1039065385a.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Nov 2026 22:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795500515; x=1796105315; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=fgKeFyUloZz+4RhvVfbCtNIKV6icyOjE4L2mgLs/w6wXQvTutee3+hNMa8CNzP8/N1
         6uWrzN86OOyMGHv1IKZYkdAq6gpN0k2hvXm4xf0MlfKNaHihKwM8F+Uy/soEZOgxJG1+
         xa/z/OjiD0sh1kWkBqjTBpvQNnXyUHasw4I/BD1xl2eTNT0WqRkz32NOsW+lSWsSSo9m
         OsZV53cpImzwG6nxbzZVCdjlzLqEwgggU+MWfcvxToB52d8Ig3ps9YFzE9zL/ReFDpcl
         d04QStMK4Gc8wFqaymj0b9G2n/r8SBRQfpQShmUe+i5Wpdytharw3fmlbcRmEgH/MdhH
         oo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795500515; x=1796105315;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=eI25TBAJDiYeBPwbBf0lZMrQXp5BCAj6d+LXHlUZPSyfZzsjF46Ruxgyx0E0YfrZi1
         kM/ic2Ms8yy5Dw/ofVgpjuJBQVzabf3tsLpvam/ZqBIJnL5Qo2a1LdyRx9bIVpLNLFGs
         YwSbHRDv2UtLGyedSStawEyEmIgWyQ94A9NntD7Vy2yfNvXyrdIkhi1ShJ1iOptsBGmx
         kmURMhCk+BKB08AMD2gSnQ4eZ7QUrSoHm88GB/nm67KRQYwd5ASc3uC/6+gmdm7dK/XE
         Jv7QMzh2ucNuBDIkQqB7VCg0zamSNH/9CXgXma0T3zt4AZTRMnSFOOYcJc9XRa6RhGjL
         mfhw==
X-Forwarded-Encrypted: i=1; AL+hErGtK0IJRXc3FBFqdvoLnxWSxUtXUCxHl6HEy+tBoYvInCyPNgZG9B7VMQtR4YpSKol209VccptY4brJWOI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/jICfa4DlKv/soaxMo+WigrmDmHNFvsjmLoPEt/xgF7OhjW5Wr
	k5Pu77FG5zwVmiLJzvR8oPojX53iOJqa7VS52OB6AaLsgeGtq2dA0R5n0Z0AAknX9Eftz2mq1Md
	nC/6scy3r2x2geFLK4jfmNdLsmYH+EnQWUgtE8D1oTnnO065jY6IDJ55zqy/qt0rQcnGj
X-Gm-Gg: AZFdTZdVOCD40XgwNg+iBYNANZ49611KaBtK+gFl3C/zVkOHOlqAXUoFqW/qfwrDBN7
	DFD/UWHQkrq4oG6mwPUMMO2UMbvWFRh3s1r6MKVD4PapKIfALn7uG8iQztmLpXvXyC8cFeMNbMU
	RuC9o5dSZYDQcw1ez0y3+a3AjMMpsab5XWmGlDUC3wns76Q3BYbVgH2UxbScnGaWXI1vvl6/Atq
	1zUhLOYuMUFlqSqqnWqffzVLTRlk4WSPDqfZk6aVyq4VtlI1t7HIZbgXYKUs6AejwS7zOAYSio0
	TyIF9W3Ra37S/2i37HExJGn2xHPYwVCikdYLRRuTbZ1docozlAOib7dSaTCjdwNW3qt4vOsSe4O
	VN6s3lFhSFYaNDjwPBxn06+19vkP9uwZzj79ysNu6lMOslDjfb4mT7IaIhVnoEt4=
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id af79cd13be357-949ba683204mr2433052885a.0.1795500514549;
        Mon, 23 Nov 2026 22:08:34 -0800 (PST)
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id af79cd13be357-949ba683204mr2433050285a.0.1795500514001;
        Mon, 23 Nov 2026 22:08:34 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ad644140b5sm23005124f8f.17.2026.11.23.22.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:08:33 -0800 (PST)
Date: Tue, 24 Nov 2026 08:08:29 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Cochran <richardcochran@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-sgx@vger.kernel.org,
        selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/14] soc: qcom: rmtfs_mem: convert mmap hook to
 mmap_prepare
Message-ID: <7zkdydihgjnqxerwzbebrcryry37hcqc47dpzqmoxdgc7qt3i6@uanst4lmvvkn>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
 <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
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
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-10-c56aadfbab8a@kernel.org>
X-Proofpoint-GUID: oTdR2mb2rvLAUKXfTUAe1p6wmND_tr-a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyNCBTYWx0ZWRfX80+d28borgmy
 GTRT7+mUFk3ApVJGrX3HBovibhi73B/ar+gWzyuqjAS9YGkYk4zxDDz08uSmC+CSH8hXEVgQlRc
 btVVx9OMBEw9JsgaiRrhi7l47x8fV6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyNCBTYWx0ZWRfX7LThCiMf8TqK
 yB1ztxKkjaf+wqjL693bxJ9hvRA6pX0VlcutWE9IHGTpKXqffQZzWshCtHiWGFNRubwYdAOpPFn
 C0BtZMy0ajh2uddzZQVY4pwXTUwbjeet9QRgCKyRxReJAfxJbsuwvDXaGKab5iV3cXybLdF/cPx
 AYrY+g+K2yE83HI3geEBfJmtVFV6WiCg71575oH8pzZcioM3YGzyFMX8FuRcOpUWifoIowAy0KT
 PBqXOsOgS4ooF+Z/3EO1ru0drWd6oc7q125MrR73xx4mTQyAbgXOUl0zLCzddp4eGEcw0iPczmu
 zXEriGjru5zYNciuAp2ADy4aa+rZowdqp6U+uOaqGLIkMvZRXnR921Rquyco3xIRx/RR9WiWbPw
 y7hwpG/pJvOD+JC0S/W1wMamMN/z6f277sgemfJPiuIVdr/b3PUX0vGIcH2ypvCpPIKkcBb5SaN
 3GulcbALlQtP6xKI24g==
X-Proofpoint-ORIG-GUID: oTdR2mb2rvLAUKXfTUAe1p6wmND_tr-a
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b0529e3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240024
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-11-05 21:05:41, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using the
> PFN remap mmap action to map the region.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

