Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B4606A322
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7tN8K28
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNTvX0HlKz2y7r;
	Mon, 09 Nov 2026 23:42:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794216767;
	cv=none; b=cF1DPS8r9WVZG15+00pH3amZYwqv3Z2x+UKzRH2V4/7O3Pmv1QY0NZgqeTN1u/RcihUyIfu8muSxy8Jd4KE/XGL5w4JKBTWLpiUWf2pJy8HWG54G63MyMijEMDslD4b26Qtsj/qKwJIblNVhAHvhtmiTpRQP+PuuzPb8rPZN/7J22Rb69VNsY+dOHaSk9r3qHjN/vA61mCZSretwyh++g+85q+16qBmO7PaUGCoul5IL2LiIIU5LnRD8k6eoUePuPTQ7VOesve4jM3UkwTdYkkj7kt9Qw4GPso8aToV/xVPPImrHX4DqW9KTJwHG+cfezx49GxGLitQMn50o/iwISw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794216767; c=relaxed/relaxed;
	bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDoFWIt1KWSRpPp+hvsPJNxWRcHGK7SNz1u1BEYj1WJ5bOpFyzOkCH26ClWgbkmKiyxvQ6UBl2ogxiWFSmbCtoblxcs5mTXLBy7stML8IJx+FEbZOEBN34ZzI3GkqEWPx7rqq6+9Xn41gYmGJKWlCoUNZPspYduGTtrG24WHnsDQBedXrTclwHYb9Torg/j5+SL0v779r+7M3dJAu9EAvlS7annZYrmm/CmLbFJT9t3sv4tQJixXXZwXM7tD8pPhuBMkhYdrj9W++PTEfNx9XUyfdzqbLp7kMXVD0BJXsNHhyj1Yn2XP1MHWMMBeszTwPcJiW4JcrUfsSeE8DnC5/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7tN8K28; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVfpLeBo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7tN8K28;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=abel.vesa@oss.qualcomm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1078 seconds by postgrey-1.37 at boromir; Mon, 09 Nov 2026 20:32:46 AEDT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNPhZ5gXPz2xKx
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 20:32:45 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96ADrD3634591
	for <linux-aspeed@lists.ozlabs.org>; Mon, 9 Nov 2026 09:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvY4KBfiISm+CQm5KIDUrtb6
	uzBgUaP0PFQaZpqv52w=; b=CVfpLeBo3svBArcIsMoE8xRGgAiB5mlup0YLE+WU
	miqzZlFGvtGNDDsox8E4acOXK3gFfIwXz4N9NuUoFgsvQYzB36fLfpJjeTRHqc6s
	uy0gSyaVcClNbyTOzA2q8KZ6eX3yeJTqJ/ms2Qw2AhTUM6hxMMbK1fitbXikNI1A
	3N1EEpVY6+IW/Gl778ykaY1gR/3PEmrnDIUD2fTp/fa3Hmb8ffAS6UIbg308OCav
	3+Nx4dhrSnt3yHskSXih/XRxBQbXscbe0NIynFJkTP78h6opo1QkdQ+HiyPEGFcV
	CwIq9i7JbhtLjvjXIsVC9XTOcHDqrOSl9f6bgU8BbCtJVA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2gy9y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 09:14:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f37c94ceeso134961185a.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 01:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794215683; x=1794820483; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=f7tN8K28Q1gBy3elE7601VPnW85zfg9npddhLuGZTIt8I29yY1IcOvGy5beQq7svEa
         +zNk0DO+s7cPsoUmLTg/tzHfyHGiKjazFfAiIXrLPPAyOxqs8WclGvyrvd53uvOKfTRH
         VQedRAe6pgs4C1LVVyLH/FNTi9FCOmQ0EF/LmQkO6QSyPegOqzA4oFqXb7v6DMrRjaeJ
         N/tMmjYOQe6RBoSQYnLXMGpfFPoYm6NGHSwKBdwQ/+wvsLD8MLrIGOhK50+Fuo9BTfeE
         YQoS5jDTquqRoCyjzEhJnlykfPzO4ISSC+UE+OeKacyhW7iCBnge0Dwyt901gPPY3fAF
         Mugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215683; x=1794820483;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvY4KBfiISm+CQm5KIDUrtb6uzBgUaP0PFQaZpqv52w=;
        b=1kXCL14FTV5Rwoso0QOkzw4T90vvd3pRyB4jTNT40iCKVzJekvESGuTUeaBL8y8SH/
         2koQNR+M0YPt/Ve0v+foL7KTw8OenX/Jq3ID6FJmEGC2dShtLuGOzGCQhdVRloZ9m3uQ
         hXN8/GAs5gOz+VUi0tFl1cogF/4WYKNWZKeI/86/9s/DAyhiOFE/0mGy3yzOiKMqXIrm
         s0FtZCTGda86N63A2LOcQsUe7YiTADBEfHP6bZeLLT3CrfBefx/kBTkwbzjZtHs34lgK
         OxWJHfwlDvamKsUQI78fbQPWLiRas1t6WuwIXooLJ+6VO0dlaht0kykx/KNLjvlYuZKV
         5FqQ==
X-Forwarded-Encrypted: i=1; AL+hErH3inHlxIJJoZi4j/vZRY7NsHmRU1tNnz7Pg6ZoBkpmC7Yhx3zj9nR6yITeuGHPoSBDA6effL/z3xbFuSM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9s2Ne8izg/Xh1MPMKpZ3qeUX1UryP7THjy1QqFRhI2Fvi89SXP
	KC9O6wMI1DUiKFbowq5XHGbs6+ShsFi15VJ1xJXeJ3aJ6/LUCw9MPvlgNCFVkTJJQzzSkgj8IHL
	Ns25ly1X0TLm0GUzn/EmtcLbC9VMfWkVeWKOQ4LQN6sLq2DNU6+Ovsg1Xisv+dmItqrsB
X-Gm-Gg: AYBFou2uH6nGc3Mgekgy8R0iKXnj+fDlUC2GFKELrLbUaJjCqBHCyuHPfwBOk7BFO+2
	BnC3G+vPwNYqvTnF3JaxPs8DRU6s8iiR0wNLnTIamxXTTPuxrKftNP5kuFis+NE6BVpitRw+SiO
	kv5MnA/uJqfNGcwxuxnU2s1nNXyhxix6/TAc+OSECslSfQ9PRUqUXZZ9MJYXy7F5yg4wLbIFmnu
	kOH5S5nk6qa2TbP7TUHMKWg6q5ammYZqxm9kWGXA3jmHEt79Rj89arLAKAsYo+jdlzVXMKV3JIX
	WxS7w86/rF2KJlMTuwrEyrXXZ8ESV5h913rA+KBbKi65OoIBEP60mWfttGkP6vUa9lPTWX2jWB/
	UlbwiChQC5JYSGJsHLJHO1ku2igleMHTLSS1qHfTCnzdkfpETx59HiNn5z0awcjA=
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886326885a.13.1794215683466;
        Mon, 09 Nov 2026 01:14:43 -0800 (PST)
X-Received: by 2002:a05:620a:1a16:b0:93c:65e3:df81 with SMTP id af79cd13be357-94604d2c6e2mr886320985a.13.1794215682798;
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b795024730sm161196965e9.4.2026.11.09.01.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:14:42 -0800 (PST)
Date: Mon, 9 Nov 2026 11:14:38 +0200
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
Message-ID: <tr3hhmd6gqvvzrngazyovx7jfbw6k45yjw2mipqu3aegsy5oda@7qromidf5btb>
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
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af18f04 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2UNkV1bVvYdQOko7pskA:9 a=CjuIK1q_8ugA:10
 a=QtEvL3ry9E0A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX1BzKkmulgy8k
 FjsbzkMobVl2niZ9UgJP3N27Pa4WZ3w4g4AGpIIUizsSLTz0SXeeyeaT/PiyO/IAyWy7OvAfChi
 j4/Uk8oR4Xx9TjtkdFGbqw0XH5tWzULtrEfljINItbU6F/X5W6O0WLHNL77i2JlvZFQvZo1zXz3
 r+/PlQKbuP1uiZjcjIM9JK59l2VYA/9UX37XL2MvSrIrM2260rI9W5/GnuHtaPoA+QFKcut7fTB
 dXRC75oOZC4rj1C+cpbM16vn1Sr+JHwt/sHrDL+G/wQdhoCHxkRKd/TxNKx5XdBVaaGC6DkVyow
 ILPHcfRxmZKpIodP2N5ovtj2qI0zkazLuiqsxahwkafknmylxFITQKNh0B/A6ecKinr1g6uTuW/
 4jJ3RIiX0k+Qj8fzVmk6yBWylW7UuC9EC60OHXknXaJvG4OocgVoGQpJKm9HqC3VRfiHgC0U94B
 dmrBM15RsDPwXbuWuTg==
X-Proofpoint-GUID: yj2ANJirpLWxVka-YCJ7sDB6sE2PQJW0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzNiBTYWx0ZWRfX95sHY0y0xsZY
 Tgtk1KmXbuoG4ZholnLg9Yvkjh3S/w27DP0p4ZKwFS4JRTAYjC4RNQ7Xvx04jw9YyBPsSPScYIp
 5z/ohk6s7z0wvSU0Uve0ohbwX4a1uco=
X-Proofpoint-ORIG-GUID: yj2ANJirpLWxVka-YCJ7sDB6sE2PQJW0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090036
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 26-11-05 21:05:41, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook, using the
> PFN remap mmap action to map the region.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

