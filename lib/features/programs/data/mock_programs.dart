import '../models/program.dart';

/// Mock data for programs.
final List<Program> mockPrograms = [
  Program(
    id: '1',
    name: 'AI Engineer Pathway',
    shortDescription:
        'Master artificial intelligence and machine learning fundamentals',
    fullDescription:
        'Embark on a comprehensive journey into the world of AI and machine '
        'learning. This program covers everything from fundamental concepts to '
        'advanced deep learning techniques, preparing you for a career as an '
        'AI engineer.',
    duration: '12 weeks',
    difficulty: ProgramDifficulty.intermediate,
    thumbnailPath: 'assets/programs/ai.webp',
    author: 'Dr. Sarah Mitchell',
    authorBio:
        'Ph.D. in Computer Science with 10+ years of experience in AI research '
        'and industry applications. Former lead AI scientist at major tech '
        'companies.',
    modules: const [
      ProgramModule(
        title: 'Introduction to AI & ML',
        description: 'Fundamental concepts, terminology, and applications',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Python for AI',
        description: 'NumPy, Pandas, and essential ML libraries',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Machine Learning Algorithms',
        description: 'Supervised and unsupervised learning techniques',
        duration: '3 weeks',
      ),
      ProgramModule(
        title: 'Deep Learning & Neural Networks',
        description: 'CNNs, RNNs, and modern architectures',
        duration: '3 weeks',
      ),
      ProgramModule(
        title: 'AI Project & Deployment',
        description: 'Build and deploy a real-world AI application',
        duration: '2 weeks',
      ),
    ],
  ),
  Program(
    id: '2',
    name: 'Cloud Architect Program',
    shortDescription:
        'Design and implement scalable cloud infrastructure solutions',
    fullDescription:
        'Learn to design, build, and manage enterprise-grade cloud '
        'infrastructure. This program covers major cloud platforms (AWS, Azure, '
        'GCP) and best practices for cloud architecture, security, and cost '
        'optimization.',
    duration: '10 weeks',
    difficulty: ProgramDifficulty.advanced,
    thumbnailPath: 'assets/programs/cloud.webp',
    author: 'James Chen',
    authorBio:
        'AWS & Azure certified architect with 15 years of experience in cloud '
        'infrastructure. Previously led cloud migration projects for Fortune '
        '500 companies.',
    modules: const [
      ProgramModule(
        title: 'Cloud Computing Fundamentals',
        description: 'Core concepts, service models, and deployment strategies',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'AWS Deep Dive',
        description: 'EC2, S3, Lambda, and core AWS services',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Azure & GCP Essentials',
        description: 'Multi-cloud strategies and platform comparison',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Cloud Security & Compliance',
        description: 'IAM, encryption, and regulatory compliance',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Architecture Capstone Project',
        description: 'Design a complete cloud solution for a real scenario',
        duration: '2 weeks',
      ),
    ],
  ),
  Program(
    id: '3',
    name: 'Cyber Sentinel',
    shortDescription:
        'Become a cybersecurity expert and protect digital assets',
    fullDescription:
        'Develop comprehensive cybersecurity skills to protect organizations '
        'from modern threats. Learn ethical hacking, penetration testing, '
        'security architecture, and incident response.',
    duration: '14 weeks',
    difficulty: ProgramDifficulty.intermediate,
    thumbnailPath: 'assets/programs/cyber.webp',
    author: 'Alex Rodriguez',
    authorBio:
        'CISSP and CEH certified cybersecurity professional with extensive '
        'experience in penetration testing and security consulting. Former '
        'security lead at government agencies.',
    modules: const [
      ProgramModule(
        title: 'Cybersecurity Fundamentals',
        description: 'Threat landscape, security principles, and CIA triad',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Network Security',
        description: 'Firewalls, VPNs, IDS/IPS systems',
        duration: '3 weeks',
      ),
      ProgramModule(
        title: 'Ethical Hacking',
        description: 'Penetration testing methodologies and tools',
        duration: '3 weeks',
      ),
      ProgramModule(
        title: 'Application Security',
        description: 'OWASP Top 10, secure coding practices',
        duration: '3 weeks',
      ),
      ProgramModule(
        title: 'Incident Response & Forensics',
        description: 'Handling security breaches and digital forensics',
        duration: '3 weeks',
      ),
    ],
  ),
  Program(
    id: '4',
    name: 'Data Driver',
    shortDescription:
        'Transform data into actionable insights and business value',
    fullDescription:
        'Master the art and science of data analytics and data science. Learn '
        'to collect, process, analyze, and visualize data to drive business '
        'decisions using modern tools and techniques.',
    duration: '11 weeks',
    difficulty: ProgramDifficulty.beginner,
    thumbnailPath: 'assets/programs/data.webp',
    author: 'Maria Santos',
    authorBio:
        'Data scientist with a background in statistics and 8 years of '
        'experience in business intelligence. Published researcher and former '
        'analytics director at startups.',
    modules: const [
      ProgramModule(
        title: 'Data Analytics Foundations',
        description: 'Statistics, probability, and analytical thinking',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'SQL & Database Management',
        description: 'Query optimization and database design',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Python for Data Science',
        description: 'Pandas, NumPy, and data manipulation',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Data Visualization',
        description: 'Tableau, Power BI, and storytelling with data',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Analytics Capstone',
        description: 'Complete data analysis project from scratch',
        duration: '3 weeks',
      ),
    ],
  ),
  Program(
    id: '5',
    name: 'The DevOps Pipeline',
    shortDescription: 'Master CI/CD, automation, and modern software delivery',
    fullDescription:
        'Learn to bridge development and operations with modern DevOps '
        'practices. Master continuous integration, continuous deployment, '
        'infrastructure as code, and container orchestration.',
    duration: '9 weeks',
    difficulty: ProgramDifficulty.intermediate,
    thumbnailPath: 'assets/programs/devops.webp',
    author: 'Kumar Patel',
    authorBio:
        'DevOps engineer with expertise in Kubernetes, Docker, and cloud '
        'automation. 12 years of experience scaling infrastructure for '
        'high-traffic applications.',
    modules: const [
      ProgramModule(
        title: 'DevOps Culture & Practices',
        description: 'Principles, culture, and collaboration strategies',
        duration: '1 week',
      ),
      ProgramModule(
        title: 'Version Control & Git',
        description: 'Advanced Git workflows and branching strategies',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'CI/CD Pipelines',
        description: 'Jenkins, GitHub Actions, GitLab CI',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Containers & Orchestration',
        description: 'Docker, Kubernetes, and container management',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Infrastructure as Code',
        description: 'Terraform, Ansible, and automation',
        duration: '2 weeks',
      ),
    ],
  ),
  Program(
    id: '6',
    name: 'The Full-Stack Accelerator',
    shortDescription:
        'Build complete web applications from front-end to back-end',
    fullDescription:
        'Become a versatile full-stack developer capable of building modern '
        'web applications end-to-end. Learn front-end frameworks, back-end '
        'technologies, databases, and deployment strategies.',
    duration: '16 weeks',
    difficulty: ProgramDifficulty.beginner,
    thumbnailPath: 'assets/programs/fullstack.webp',
    author: 'Emily Zhang',
    authorBio:
        'Full-stack developer and educator with 9 years of experience. Former '
        'lead developer at tech startups and passionate about teaching modern '
        'web development.',
    modules: const [
      ProgramModule(
        title: 'Web Development Fundamentals',
        description: 'HTML, CSS, JavaScript, and responsive design',
        duration: '3 weeks',
      ),
      ProgramModule(
        title: 'Front-End Framework',
        description: 'React.js or Vue.js, state management',
        duration: '4 weeks',
      ),
      ProgramModule(
        title: 'Back-End Development',
        description: 'Node.js, Express, RESTful APIs',
        duration: '4 weeks',
      ),
      ProgramModule(
        title: 'Databases',
        description: 'SQL and NoSQL databases, ORM',
        duration: '2 weeks',
      ),
      ProgramModule(
        title: 'Full-Stack Project',
        description: 'Build and deploy a complete web application',
        duration: '3 weeks',
      ),
    ],
  ),
];
